global class CaseControllerExt {
    private final Case acase;
    public String name {get; set;}
    public String rut {get; set;}
    public String phone {get; set;}
    public String email {get; set;}
    public String nomPag {get; set;}
    public String rutPag {get; set;}

    public CaseControllerExt(ApexPages.StandardController stdController){
        this.acase=(Case)stdController.getRecord(); 
        this.name = ApexPages.currentPage().getParameters().get('name');
        this.rut = ApexPages.currentPage().getParameters().get('rut');   
        this.phone = ApexPages.currentPage().getParameters().get('phone');   
        this.email = ApexPages.currentPage().getParameters().get('email');   
        this.nomPag = ApexPages.currentPage().getParameters().get('nomPag');   
        this.rutPag = ApexPages.currentPage().getParameters().get('rutPag'); 
    } 
    
    @RemoteAction
    global static String attachBlob(String parentId, String attachmentId, String fileName, String contentType, String base64BlobValue, String Json){
                
        Case d = new Case();
        d = des(Json);
                
        //If recordId is blank this is the first part of a multi piece upload
        if(attachmentId == '' || attachmentId == null){
            Attachment att = new Attachment(
                ParentId = d.id,
                Body = EncodingUtil.Base64Decode(base64BlobValue),
                Name = fileName,
                ContentType = contentType
                //Ownerid = '0053t00000835s1AAA'
                //createdbyid = '005q00000075jorAAA'
            );
            Database.Saveresult sr;
            try{
                sr = Database.insert(att);            
                //Return the new attachment Id
                //return att.Id;
                //return d.id;
                return Json(d.id, att.Id);
            }catch(DmlException e){
                return e.getMessage();
                
            }                     
        }else{
            for(Attachment atm : [select Id, Body from Attachment where Id = :attachmentId]){
                //Take the body of the current attachment, convert to base64 string, append base64 value sent from page, then convert back to binary for the body
                update new Attachment(Id = attachmentId, Body = EncodingUtil.Base64Decode(EncodingUtil.Base64Encode(atm.Body) + base64BlobValue));
            }            
            //Return the Id of the attachment we are currently processing
            return Json(d.id, attachmentId);
        }
    }        
    
    public static Case des(string s){
        constructorCase j = (constructorCase) JSON.deserialize(s, constructorCase.class);
        
        integer i = [Select count() from Case where id =: j.id];
        
        if(i>0){
            Case pr = [Select id from Case where id =: j.id];
            return pr;
        } else {
            Case c = new Case();
            List<RecordType> NR = [select id from RecordType where name =: 'Post venta' limit 1];
            
            c.SuppliedName = j.nombre; c.HDI4I_Rut__c = j.rut; c.SuppliedPhone = j.telefono; c.SuppliedEmail = j.email; /*c.Subject = j.asunto; */ c.Subject = j.motivo; c.Reason = j.motivo; c.Description = j.descripcion; c.HDI4I_Nombre_del_pagador__c = j.nombrePagador; c.HDI4I_Rut_del_pagador__c = j.rutPagador;
            c.Banco_del_pagador__c = j.banco; c.HDI4I_Tipo_cuenta_del_pagador__c = j.tipoCuenta; c.HDI4I_N_de_cuenta_del_pagador__c = j.nCuenta; c.HDI4I_Mail_confirmaci_n_del_pagador__c = j.emailConfirmacion; c.Status = 'Ingresado'; c.Origin = 'Web'; c.Type = 'Devolución';
            c.RecordTypeId = NR[0].id; c.Priority = 'Medium'; c.HDI4I_Sub_Tipo__c = j.subTipo; c.HDI4I_VF__c = True;
            
            if(c.HDI4I_Sub_Tipo__c == 'Devolución Corredores'){
                c.HDI4I_C_digo_corredor__c = j.codCorredor; 
                c.HDI4I_Nombre_del_corredor__c = j.nombreCorredor;
                c.Subject = j.asunto;
            }
            
            integer existe = [Select count() from Contact where Email =:c.SuppliedEmail];
            if(existe > 0){
               List<Contact> contact = [Select id from Contact where Email =: c.SuppliedEmail];
               c.ContactId = contact[0].id;
            }
            
            Database.DMLOptions dmo = new Database.DMLOptions(); 
        	dmo.assignmentRuleHeader.assignmentRuleId= '01Q3t000000JMPzEAO';
        	c.setOptions(dmo);
            insert(c);
            return c;
        }        
    }
    public static String Json(String idd, String ataid){
        ConstructorJson jj = new ConstructorJson();
        jj.idd = idd;
        jj.ataid = ataid;
        
        string jason = JSON.serialize(jj);
        return jason;
    }
}