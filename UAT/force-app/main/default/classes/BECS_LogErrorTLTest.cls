@isTest
public with sharing class BECS_LogErrorTLTest {
    
    @IsTest
    static void methodName(){
        
        Test.startTest();
            BECS_OpportunityAPI.InParameters jsonToTest = new BECS_OpportunityAPI.InParameters();
            jsonToTest.idHdiOpWeb = '1234';
            BECS_OpportunityAPI.InParameters jsonToTest2 = new BECS_OpportunityAPI.InParameters();
            HDI_ApiSiniestroJSON jsonSiniestro  = new HDI_ApiSiniestroJSON();

            list<ORG_IntegrationLogError__c> logError = new list<ORG_IntegrationLogError__c>();   
            logError.add(BECS_LogErrorTL.fullLog('Success', jsonToTest, 'Correcto','',jsonSiniestro));
            logError.add(BECS_LogErrorTL.fullLog('Error', jsonToTest, 'No procesado', 'Error',jsonSiniestro)); 
            logError.add(BECS_LogErrorTL.fullLog('Error', jsonToTest, 'Pendiente', 'Error',jsonSiniestro)); 
            logError.add(BECS_LogErrorTL.fullLog('Success', jsonToTest2, 'Correcto','',jsonSiniestro));
            logError.add(BECS_LogErrorTL.fullLog('Error', jsonToTest2, 'No procesado', 'Error',jsonSiniestro)); 
            logError.add(BECS_LogErrorTL.fullLog('Error', jsonToTest2, 'Pendiente', 'Error',jsonSiniestro)); 
            new BECS_LogErrorTL(logError).insertLogs(logError);

            List<ORG_IntegrationLogError__c> newList = [Select ORG_Solicitud__c,ORG_Estado__c,ORG_Proyecto__c From ORG_IntegrationLogError__c];
            HDI_LogErrorTL.retryCreateOpportunity(newList);

        Test.stopTest();
        
    }
}