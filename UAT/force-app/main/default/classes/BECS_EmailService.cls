public with sharing class BECS_EmailService {
    
    @future
    public static void enviarCorreo(string objectName, Set<Id> listId){
        String nombreEmailCampana = 'Cotizaci_n_seguro_de_veh_culo_1608034952302';
        String nombreEmailCampanaBancoEstado = 'BancoEstado_1636648164324';

        Map<String,EmailTemplate> mapTemplates = new Map<String,EmailTemplate>();
        for (EmailTemplate item : [SELECT DeveloperName, Subject, HtmlValue, enhancedletterheadid FROM EmailTemplate WHERE DeveloperName =: nombreEmailCampana OR DeveloperName =: nombreEmailCampanaBancoEstado]) {
            mapTemplates.put(item.DeveloperName, item);
        }

        Map<String,OrgWideEmailAddress> mapOWE = new Map<String,OrgWideEmailAddress>();
        for (OrgWideEmailAddress item : [SELECT Address FROM OrgWideEmailAddress]) {
            mapOWE.put(item.Address, item);
        }

        String emailAddress;
        String emailOwner;
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();

        if(objectName == 'Quote'){
            List<Quote> listQuotes = new BECS_QuoteSelector().selectById(listId);
            for (Quote item : listQuotes) {
                EmailTemplate templates = mapTemplates.get(nombreEmailCampana);
                if (item.Opportunity.BECS_BancoEstado__c) {
                    templates = mapTemplates.get(nombreEmailCampanaBancoEstado);    
                }
                //Messaging.SingleEmailMessage message = Messaging.renderStoredEmailTemplate(templates.Id, null, item.OpportunityId);
                Messaging.SingleEmailMessage message = new Messaging.singleEmailMessage();
                message.setTemplateId(templates.Id);
                message.setTargetObjectId(item.Account.PersonContactId);
                message.setWhatId(item.OpportunityId);
                message.setToAddresses(new String[] { item.Email });
                message.setCcAddresses(new String[] { item.Opportunity.Owner.Email });
                message.setBccAddresses(new String[] { Label.CorreoPropuestaBCC });
                message.setOrgWideEmailAddressId(getOrgWideEmailAddress(mapOWE, item.Opportunity.Owner.Email)); 
                List<String> listUltimaDocumentoGenerado = new List<String>();
                listUltimaDocumentoGenerado.add(item.hdi4i_ultima_cotizacion_generada__c);
                message.setFileAttachments(getAttachments(listUltimaDocumentoGenerado));
                mails.add(message);
            }

        }else if(objectName == 'FinServ__FinancialAccount__c'){
            List<FinServ__FinancialAccount__c> listInsurancePolicy = new BECS_FinancialAccountSelector().selectById(listId);
            for (FinServ__FinancialAccount__c item : listInsurancePolicy) {
                EmailTemplate templates = mapTemplates.get(nombreEmailCampana);
                if (item.FinServ__Opportunities__r[0].BECS_BancoEstado__c) {
                    templates = mapTemplates.get(nombreEmailCampanaBancoEstado);    
                }
                //Messaging.SingleEmailMessage message = Messaging.renderStoredEmailTemplate(templates.Id, null, item.SourceOpportunityId);
                Messaging.SingleEmailMessage message = new Messaging.singleEmailMessage();
                message.setTemplateId(templates.Id);
                message.setTargetObjectId(item.FinServ__Opportunities__r[0].Account.PersonContactId);
                message.setWhatId(item.FinServ__Opportunities__r[0].Id);
                message.setToAddresses(new String[] { item.FinServ__Opportunities__r[0].Account.PersonEmail });
                message.setCcAddresses(new String[] { item.FinServ__Opportunities__r[0].Owner.Email });
                message.setBccAddresses(new String[] { Label.CorreoPropuestaBCC });
                message.setOrgWideEmailAddressId(getOrgWideEmailAddress(mapOWE,item.FinServ__Opportunities__r[0].Owner.Email));
                List<String> listUltimaDocumentoGenerado = new List<String>();
                listUltimaDocumentoGenerado.add(item.BECS_UltimaPolizaGenerada__c);
                message.setFileAttachments(getAttachments(listUltimaDocumentoGenerado));
                mails.add(message);
            }

        }           
        if(!mails.isEmpty() && !Test.isRunningTest()){
            Messaging.SendEmail(mails, false);
        }
    }

    public static Id getOrgWideEmailAddress(Map<String,OrgWideEmailAddress> mapOWE, String email){
        OrgWideEmailAddress orgWideEmail = mapOWE.get('posventa.hdi.salesforce@gmail.com');

        if (mapOWE.containsKey(email)) {
            orgWideEmail = mapOWE.get(email);  
        }
        return orgWideEmail.Id;
    }

    public static List<Messaging.EmailFileAttachment> getAttachments(List<String> listUltimaDocumentoGenerado){
        List<String> listContentDocumentId = new List<String>();
        for(ContentDocument cd : [select id from ContentDocument where title IN: listUltimaDocumentoGenerado]){
            listContentDocumentId.add(cd.id);
        }

        List<ContentVersion> contentVersion = [select title, versiondata, fileType,contentdocumentid from contentversion where contentdocumentid IN: listContentDocumentId];
            
        List<Messaging.EmailFileAttachment> attachments = new List<Messaging.EmailFileAttachment>();
        for (ContentVersion cv: contentVersion) {
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            blob cvbody = cv.versiondata;
            efa.setFileName(cv.title+'.'+cv.fileType.toLowerCase());
            efa.setBody(cvbody);
            attachments.add(efa);
        }
        return attachments;
    }
}