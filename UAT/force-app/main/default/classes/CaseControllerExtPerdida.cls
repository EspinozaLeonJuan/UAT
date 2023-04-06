global class CaseControllerExtPerdida {
    private final Case acase;
    public String name {get; set;}
    public String rut {get; set;}
    public String phone {get; set;}
    public String email {get; set;}

    public CaseControllerExtPerdida(ApexPages.StandardController stdController){
        this.acase=(Case)stdController.getRecord();
        this.name = ApexPages.currentPage().getParameters().get('name');
        this.rut = ApexPages.currentPage().getParameters().get('rut');    
        this.phone = ApexPages.currentPage().getParameters().get('phone');
        this.email = ApexPages.currentPage().getParameters().get('email');    
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
            List<RecordType> NR = [select id from RecordType where name =: 'Pérdida Total' limit 1];
            c.SuppliedName = j.nombre; c.HDI4I_Rut__c = j.rut; c.SuppliedPhone = j.telefono; c.SuppliedEmail = j.email; c.Subject = j.motivoPerdida; /*j.asunto;*/ c.Description = j.descripcion;
            c.Status = 'Ingresado'; c.Origin = 'Web'; c.Type = 'Pérdida Total';
            c.RecordTypeId = NR[0].id; c.Priority = 'Medium'; c.HDI4I_Sub_Tipo__c = j.subTipo; c.Reason = j.motivoPerdida; c.HDI4I_N_Siniestro__c = j.nSiniestro; c.Relaci_n_con_asegurado__c = j.relacionA;
            c.HDI4I_VF__c = True;
            
            if(c.HDI4I_Sub_Tipo__c == 'Pérdida total corredor'){
                c.HDI4I_C_digo_corredor__c = j.codCorredor; 
                c.HDI4I_Nombre_del_corredor__c = j.nombreCorredor;
                c.Subject = j.asunto;
            }
            
            integer existe = [Select count() from Contact where Email =:c.SuppliedEmail];
            if(existe > 0){
               List<Contact> contact = [Select id from Contact where Email =: c.SuppliedEmail];
               c.ContactId = contact[0].id;
            }
            
            /*Database.DMLOptions dmo = new Database.DMLOptions(); 
        	dmo.assignmentRuleHeader.assignmentRuleId= '01Q3t000000JMPzEAO';
        	c.setOptions(dmo);*/
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