global class HDI_LogErroresBatch implements Database.Batchable<SObject> {
    global Database.QueryLocator start(Database.BatchableContext bc){
        String query = 'SELECT Id, ORG_Estado__c, ORG_FechaHoraError__c, ORG_Proyecto__c, ORG_Reintentos__c, ORG_Solicitud__c FROM ORG_IntegrationLogError__c ';
        query += ' WHERE ORG_Estado__c != \'Procesado\' AND (ORG_Reintentos__c < 5 OR ORG_Reintentos__c = null) ORDER BY CreatedDate ASC LIMIT 50000';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext bc, List<SObject> scopeList){
        List<ORG_IntegrationLogError__c> errorList = new List<ORG_IntegrationLogError__c>();
        
        for(SObject item : scopeList){
            ORG_IntegrationLogError__c errorItem = (ORG_IntegrationLogError__c) item;
            errorItem.ORG_Estado__c = 'Pendiente';
            errorItem.ORG_Reintentos__c = errorItem.ORG_Reintentos__c == null ? 1 : errorItem.ORG_Reintentos__c + 1;
            errorList.add(errorItem);
        }

        if(!errorList.isEmpty()){
            update errorList;
        }
    }

    global void finish(Database.BatchableContext bc){
        System.debug('finish');
    }
}