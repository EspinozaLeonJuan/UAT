global class correosCasos {

    global static void semilla(List<Case> casos){
        String emailAddress = casos[0].SuppliedEmail;
        List<EmailTemplate> templates = new List<EmailTemplate>();
        
        if(casos[0].Type == 'Devolución'){
            templates = [SELECT Id, Subject, HtmlValue, enhancedletterheadid FROM EmailTemplate WHERE DeveloperName = 'SERVICIO_Autorespuesta_de_Web_to_Case_Devoluciones'];
        } else if(casos[0].Type == 'Pérdida Total'){
            templates = [SELECT Id, Subject, HtmlValue, enhancedletterheadid FROM EmailTemplate WHERE DeveloperName = 'SERVICIO_Autorespuesta_de_Web_to_Case_P_rdidas_Totales'];
        }
        
        
        
        Messaging.SingleEmailMessage message = Messaging.renderStoredEmailTemplate(templates[0].Id, null, casos[0].id);
        message.setToAddresses(new String[] { emailAddress });
        
        List<OrgWideEmailAddress> addresses = [SELECT Id FROM OrgWideEmailAddress WHERE Address = 'postventa-salesforce@hdi.cl'];
        if (!addresses.isEmpty()) {
            message.setOrgWideEmailAddressId(addresses[0].Id);
            system.debug(addresses[0].Id);
        }
        
        message.setSaveAsActivity(true);
        try {
            Messaging.SendEmailResult[] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });
            system.debug(r);
        } catch (DmlException e) {
            //Errores(e.getMessage());
        }
    }
    
    /*global static void Errores(String err){
        String emailAddress = 'cl.cortesp89@gmail.com';
        string body = err;
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[] { emailAddress });
        List<OrgWideEmailAddress> addresses1 = [SELECT Id FROM OrgWideEmailAddress WHERE Address = 'ccortes@cuatroi.com'];
        email.setOrgWideEmailAddressId(addresses1[0].id);
        email.setSubject(err);
        email.setHtmlBody(body);
        try {
            Messaging.SendEmailResult[] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
            system.debug(r);
        } catch (Exception e) {
            throw e;
        }
    }*/
}