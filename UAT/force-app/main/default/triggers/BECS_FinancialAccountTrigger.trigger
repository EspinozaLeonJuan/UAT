trigger BECS_FinancialAccountTrigger on FinServ__FinancialAccount__c (after update) {
    new BECS_FinancialAccountTriggerHandler().run();
}