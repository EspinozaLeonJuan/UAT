global class EnviarCorreo {
    
    // CREACIÓN DE CORREO CON COTIZACIÓN ADJUNTA
    global static void Cotizaciones(List<Quote> cita){
        
        //system.debug(cita[0].name);
        //system.debug(cita[0].id);
        system.debug(cita[0].hdi4i_ultima_cotizacion_generada__c);
        system.debug(cita[0].Email);
        system.debug(cita[0].OpportunityId);
        String emailAddress = cita[0].Email;  
        //String email = 'ccortes@cuatroi.com';
        //String email2 = 'cl.cortesp89@gmail.com';
        //system.debug(llamaEmail(cita[0].OpportunityId));
        //system.debug(cita[0].ownerid);
        String emailOwner = llamaEmail(cita[0].OpportunityId);
        
        // Agregado por Fran - Inetum, para identificar la campaña para el Email
        String nombreEmailCampana = 'Cotizaci_n_seguro_de_veh_culo_1608034952302';
        if(cita[0].Opportunity.HDI4I_Campana_cotizador_web__c == 'Campaña Ejecutivo Banco Estado' || cita[0].Opportunity.HDI4I_Campana_cotizador_web__c == 'Campaña VSV Banco Estado'){
            nombreEmailCampana = 'BancoEstado_1636648164324';
        }
        // FIN, Fran Inetum

        List<EmailTemplate> templates = [SELECT Id, Subject, HtmlValue, enhancedletterheadid FROM EmailTemplate WHERE DeveloperName =: nombreEmailCampana];
        
        Messaging.SingleEmailMessage message = Messaging.renderStoredEmailTemplate(templates[0].Id, null, cita[0].OpportunityId);
        message.setToAddresses(new String[] { emailAddress });
        message.setCcAddresses(new String[] { emailOwner });
        message.setBccAddresses(new String[] { Label.CorreoPropuestaBCC });

        if (!templates.isEmpty()) {
            message.setSubject(templates[0].Subject);
        }
        
        if(existeAttachments(cita[0].hdi4i_ultima_cotizacion_generada__c)){
            ContentDocument cd = new ContentDocument();
            cd = [select id from ContentDocument where title =: cita[0].hdi4i_ultima_cotizacion_generada__c];
            system.debug(cd.id);
            
            List<ContentVersion> cvs = [select id, title, versiondata, fileType, contentdocumentid from contentversion where contentdocumentid =: cd.id];
            
            List<Messaging.EmailFileAttachment> attachments = new List<Messaging.EmailFileAttachment>();
            for (ContentVersion cv: cvs) {
                Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                blob cvbody = cv.versiondata;
                system.debug(cvbody);
                efa.setFileName(cv.title+'.'+cv.fileType.toLowerCase());
                efa.setBody(cvbody);
                attachments.add(efa);
            }
            message.setFileAttachments(attachments);
        }
        
        
        /*  Comentado por Fran, Inetum 15-12-21 
        
        if(existeOrg(emailOwner)){
            system.debug('email org');
            List<OrgWideEmailAddress> addresses = [SELECT Id, Address FROM OrgWideEmailAddress WHERE Address =: emailOwner];
            if (!addresses.isEmpty()) {
                message.setOrgWideEmailAddressId(addresses[0].Id);
                system.debug(addresses[0].Id);
                system.debug(addresses[0].Address);
            }
        }else{
            system.debug('no email org');
            List<OrgWideEmailAddress> addresses = [SELECT Id FROM OrgWideEmailAddress WHERE Address = 'posventa.hdi.salesforce@gmail.com'];
            if (!addresses.isEmpty()) {
                message.setOrgWideEmailAddressId(addresses[0].Id);
                system.debug(addresses[0].Id);
            } 
        } */
        message.setOrgWideEmailAddressId(existeOrg(emailOwner)); 
        
        message.setSaveAsActivity(true);
        try {
            Messaging.SendEmailResult[] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });
            system.debug(r);
        } catch (Exception e) {
            throw e;
        }
    }
    
    // CREACIÓN DE CORREO CON POLIZA ADJUNTA
    global static void Polizas(List<InsurancePolicy> poliza){
        
        Quote cita = new Quote();
        cita = [Select id, email from Quote where id =: poliza[0].SourceQuoteId ]; 
        String emailAddress = cita.email;
        //String email = 'ccortes@cuatroi.com';
        //String email2 = 'cl.cortesp89@gmail.com';
        //system.debug(llamaEmail(poliza[0].SourceOpportunityId));
        
        String emailOwner = llamaEmail(poliza[0].SourceOpportunityId);
        
        // Agregado por Fran - Inetum, para identificar la campaña para el Email
        String nombreEmailCampana = 'Cotizaci_n_seguro_de_veh_culo_1608034952302';
        if(poliza[0].SourceOpportunity.HDI4I_Campana_cotizador_web__c == 'Campaña Ejecutivo Banco Estado' || poliza[0].SourceOpportunity.HDI4I_Campana_cotizador_web__c == 'Campaña VSV Banco Estado'){
            nombreEmailCampana = 'BancoEstado_1636648164324';
        }
        // FIN, Fran Inetum

        List<EmailTemplate> templates = [SELECT Id, Subject, HtmlValue, enhancedletterheadid FROM EmailTemplate WHERE DeveloperName =: nombreEmailCampana];
        
        Messaging.SingleEmailMessage message = Messaging.renderStoredEmailTemplate(templates[0].Id, null, poliza[0].SourceOpportunityId);
        message.setToAddresses(new String[] { emailAddress });
        message.setCcAddresses(new String[] { emailOwner });
        message.setBccAddresses(new String[] { Label.CorreoPropuestaBCC });

        if (!templates.isEmpty()) {
            message.setSubject(templates[0].Subject);
        }
        
        if(existeAttachments(poliza[0].HDI4I_Ultima_poliza_generada__c)){
            ContentDocument cd = new ContentDocument();
            cd = [select id from ContentDocument where title =: poliza[0].HDI4I_Ultima_poliza_generada__c];
            system.debug(cd.id);
            
            List<ContentVersion> cvs = [select id, title, versiondata, fileType, contentdocumentid from contentversion where contentdocumentid =: cd.id];
            
            List<Messaging.EmailFileAttachment> attachments = new List<Messaging.EmailFileAttachment>();
            for (ContentVersion cv: cvs) {
                Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                blob cvbody = cv.versiondata;
                system.debug(cvbody);
                efa.setFileName(cv.title+'.'+cv.fileType.toLowerCase());
                efa.setBody(cvbody);
                attachments.add(efa);
            }
            message.setFileAttachments(attachments); 
        }
        
        
        /*  Comentado por Fran, Inetum 15-12-21

        if(existeOrg(emailOwner)){
            List<OrgWideEmailAddress> addresses = [SELECT Id FROM OrgWideEmailAddress WHERE Address =: emailOwner];
            if (!addresses.isEmpty()) {
                message.setOrgWideEmailAddressId(addresses[0].Id);
                system.debug(addresses[0].Id);
            }
        }else{
            List<OrgWideEmailAddress> addresses = [SELECT Id FROM OrgWideEmailAddress WHERE Address = 'posventa.hdi.salesforce@gmail.com'];
            if (!addresses.isEmpty()) {
                message.setOrgWideEmailAddressId(addresses[0].Id);
                system.debug(addresses[0].Id);
            } 
        } */
        message.setOrgWideEmailAddressId(existeOrg(emailOwner)); 
        
        message.setSaveAsActivity(true);
        try {
            Messaging.SendEmailResult[] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });
            system.debug(r);
        } catch (Exception e) {
            throw e;
        }
    }
    
    // CREACIÓN DE CORREO CON PROPUESTA ADJUNTA
    global static void Propuestas(List<Opportunity> propuesta){
        
        Quote cita = new Quote();
        cita = [Select id, email from Quote where opportunityid =: propuesta[0].id limit 1];        
        system.debug(cita.email);
        String emailAddress = cita.email;
        //String email = 'ccortes@cuatroi.com';
        //String email2 = 'cl.cortesp89@gmail.com';
        //system.debug(llamaEmail(propuesta[0].id));
        //system.debug(cita[0].ownerid);
        String emailOwner = llamaEmail(propuesta[0].id);
        
        // Agregado por Fran - Inetum, para identificar la campaña para el Email
        String nombreEmailCampana = 'Cotizaci_n_seguro_de_veh_culo_1608034952302';
        if(propuesta[0].HDI4I_Campana_cotizador_web__c == 'Campaña Ejecutivo Banco Estado' || propuesta[0].HDI4I_Campana_cotizador_web__c == 'Campaña VSV Banco Estado'){
            nombreEmailCampana = 'BancoEstado_1636648164324';
        }
        // FIN, Fran Inetum

        List<EmailTemplate> templates = [SELECT Id, Subject, HtmlValue, enhancedletterheadid FROM EmailTemplate WHERE DeveloperName =: nombreEmailCampana];
        
        Messaging.SingleEmailMessage message = Messaging.renderStoredEmailTemplate(templates[0].Id, null, propuesta[0].id);
        message.setToAddresses(new String[] { emailAddress });
        message.setCcAddresses(new String[] { emailOwner });
        message.setBccAddresses(new String[] { Label.CorreoPropuestaBCC });
        
        if (!templates.isEmpty()) {
            message.setSubject(templates[0].Subject);
        }
        
        /* if(existeAttachments(propuesta[0].HDI4I_Ultima_propuesta_generada__c)){
            ContentDocument cd = new ContentDocument();
            cd = [select id from ContentDocument where title =: propuesta[0].HDI4I_Ultima_propuesta_generada__c];
            system.debug(cd.id);
            
            List<ContentVersion> cvs = [select id, title, versiondata, fileType, contentdocumentid from contentversion where contentdocumentid =: cd.id];
            
            List<Messaging.EmailFileAttachment> attachments = new List<Messaging.EmailFileAttachment>();
            for (ContentVersion cv: cvs) {
                Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                blob cvbody = cv.versiondata;
                system.debug(cvbody);
                efa.setFileName(cv.title+'.'+cv.fileType.toLowerCase());
                efa.setBody(cvbody);
                attachments.add(efa);
            }
            message.setFileAttachments(attachments);
        } */
        
        
        
        /*  Comentado por Fran, Inetum 15-12-21

        if(existeOrg(emailOwner)){
            List<OrgWideEmailAddress> addresses = [SELECT Id FROM OrgWideEmailAddress WHERE Address =: emailOwner];
            if (!addresses.isEmpty()) {
                message.setOrgWideEmailAddressId(addresses[0].Id);
                system.debug(addresses[0].Id);
            }
        }else{
            List<OrgWideEmailAddress> addresses = [SELECT Id FROM OrgWideEmailAddress WHERE Address = 'posventa.hdi.salesforce@gmail.com'];
            if (!addresses.isEmpty()) {
                message.setOrgWideEmailAddressId(addresses[0].Id);
                system.debug(addresses[0].Id);
            } 
        } */
        message.setOrgWideEmailAddressId(existeOrg(emailOwner)); 

        message.setSaveAsActivity(true);
        try {
            Messaging.SendEmailResult[] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });
            system.debug(r);
        } catch (Exception e) {
            throw e;
        }
    }
    
    //COMPRUEBA QUE EXISTE UN DATO ADJUNTO EN LA CARPETA
    global static boolean existeAttachments(String id){
        System.debug(id);
        integer existe = [Select count() from ContentDocument where title =: id];
        if(existe >0){
            return true;
        }else{
            return false;
        }
    }
    
    Global static String llamaEmail(String oId){
        opportunity op = [Select ownerid, Owner.Email from opportunity where id =:oId];
        
        /* Comentado por Fran, Inetum 15-12-21
        
        String email = '';
        User o = [SELECT Email FROM User where id =: op.OwnerId limit 1];
        email = o.Email;
        return email;
        */
        return op.Owner.Email;
    }

    global static Id existeOrg(String email){
        /*  Comentado por Fran, Inetum 15-12-21 
        
        List<OrgWideEmailAddress> o = [SELECT Id FROM OrgWideEmailAddress WHERE Address =: email];
        if(o.size() > 0){
            return true;
        }else{
            return false;
        } */
        List<OrgWideEmailAddress> addresses = [SELECT Id FROM OrgWideEmailAddress WHERE Address =: email];
        if (addresses.isEmpty()) {
            addresses = [SELECT Id FROM OrgWideEmailAddress WHERE Address = 'posventa.hdi.salesforce@gmail.com'];
        }
        return addresses[0].Id;
    }
    
    global static boolean firmaOppo(String oppId){
        Opportunity opo = [Select HDI4I_Firma__c, HDI4I_TelEjecutiva__c, HDI4I_EmailEjecutiva__c, ownerid FROM Opportunity where id =: oppId];
        User u = [SELECT MobilePhone, Email, HDIR4I_Firma__c FROM User where id =: opo.OwnerId limit 1];
        opo.HDI4I_Firma__c = u.HDIR4I_Firma__c;
        opo.HDI4I_TelEjecutiva__c = u.MobilePhone;
        opo.HDI4I_EmailEjecutiva__c = u.Email;
        
        try{
            update opo;
            return true;
        }catch(DmlException e){
            System.debug(e.getMessage());
            return false;
        }
    }
    // COMPRUEBA QUE EXISTE UN CAMBIO EN EL ARCHIVO PDF ADJUNTO
    global static boolean nuevaCotizacion(List<Quote> antiguo, List<Quote> nuevo){
        boolean nuevaCot = false;
        for(Quote ant: antiguo){            
            for(Quote nue: nuevo){                
                if(ant.hdi4i_ultima_cotizacion_generada__c != nue.HDI4I_Ultima_cotizacion_generada__c){
                    nuevaCot = true;
                    //system.debug('Existe un nuevo campo');
                } else {
                    nuevaCot = false;
                    //system.debug('No existe un nuevo campo');
                }
            }
        }
        return nuevaCot;
    }
    // COMPRUEBA QUE EXISTE UN CAMBIO EN EL ADJUNTO DE LA PÓLIZA
    global static boolean nuevaPoliza(List<InsurancePolicy> antiguo, List<InsurancePolicy> nuevo){
        boolean nuevaPol = false;
        for(InsurancePolicy ant: antiguo){
            for(InsurancePolicy nue: nuevo){
                if(ant.HDI4I_Ultima_poliza_generada__c != nue.HDI4I_Ultima_poliza_generada__c){
                    nuevaPol = true;
                    //system.debug('Existe un nuevo campo');
                } else {
                    nuevaPol = false;
                    //system.debug('No existe un nuevo campo');
                }
            }
        }
        return nuevaPol;
    }
    // COMPRUEBA QUE EXISTE UN CAMBIO EN EL ADJUNTO DE LA PROPUESTA
    global static boolean nuevaPropuesta(List<Opportunity> antiguo, List<Opportunity> nuevo){
        boolean nuevaPro = false;
        for(Opportunity ant: antiguo){
            for(Opportunity nue: nuevo){
                if(ant.HDI4I_Ultima_propuesta_generada__c != nue.HDI4I_Ultima_propuesta_generada__c){
                    nuevaPro = true;
                    //system.debug('Existe un nuevo campo');
                } else {
                    nuevaPro = false;
                    //system.debug('No existe un nuevo campo');
                }
            }
        }
        return nuevaPro;
    }
    
    // ENVÍA MENSAJE DE ERROR 
    global static void Errores(String mensaje, String json, String mensaje1){
        /*String emailAddress = 'pruebaerroreshdi2@gmail.com';
        string body = string.valueOf('<b>'+mensaje1+'</b><br/><br/>'+json);
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[] { emailAddress });
        List<OrgWideEmailAddress> addresses1 = [SELECT Id FROM OrgWideEmailAddress WHERE Address = 'ccortes@cuatroi.com'];
        email.setOrgWideEmailAddressId(addresses1[0].id);
        email.setSubject(mensaje);
        email.setHtmlBody(body);
        try {
            //Messaging.SendEmailResult[] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
            //system.debug(r);
        } catch (Exception e) {
            throw e;
        }*/
    }
}