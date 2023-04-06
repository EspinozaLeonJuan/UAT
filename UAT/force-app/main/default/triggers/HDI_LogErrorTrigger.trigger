trigger HDI_LogErrorTrigger on ORG_IntegrationLogError__c (before update) {
    new HDI_LogErrorHandler().run();
}