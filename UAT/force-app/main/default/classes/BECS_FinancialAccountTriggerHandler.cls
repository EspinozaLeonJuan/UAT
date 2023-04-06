public without sharing class BECS_FinancialAccountTriggerHandler  extends TriggerHandler{
    private Map<Id, FinServ__FinancialAccount__c> newOpportunityMap;
    private BECS_FinancialAccount sObjectDomain;
    
    public BECS_FinancialAccountTriggerHandler() {
        this.newOpportunityMap = (Map<Id, FinServ__FinancialAccount__c>) Trigger.newMap;
        this.sObjectDomain = new BECS_FinancialAccount(records);
    } 
    
    public override void afterUpdate() {
        sObjectDomain.onAfterUpdate(newOpportunityMap);
    }
    
}