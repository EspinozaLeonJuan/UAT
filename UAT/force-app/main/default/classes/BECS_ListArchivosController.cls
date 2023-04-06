public without sharing class BECS_ListArchivosController {
    
    @AuraEnabled(Cacheable=true)
    public static List<ContentDocument> getListArchivos(String recordId){
        try {
            List<String> listParentsId = new List<String>();
            listParentsId.add(recordId);
            
            for (Opportunity item : new BECS_OpportunitySelector().selectById(listParentsId)) {
                listParentsId.add(item.FinServ__FinancialAccount__c);    
            }

            for (Quote item : new BECS_QuoteSelector().selectByOpportunityId(listParentsId)) {
                listParentsId.add(item.id);    
            }

            for (ContentDocumentLink item : [SELECT ContentDocumentID FROM ContentDocumentLink WHERE LinkedEntityId IN: listParentsId]) {
                listParentsId.add(item.ContentDocumentID);    
            }

            return [select Id, Title, CreatedDate, FileExtension 
                    From ContentDocument 
                    Where Id IN: listParentsId
                    Order by createdDate desc];
                    
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}