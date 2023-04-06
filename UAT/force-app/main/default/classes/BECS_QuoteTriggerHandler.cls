public without sharing class BECS_QuoteTriggerHandler extends TriggerHandler{
    private Map<Id, Quote> newOpportunityMap;
    private BECS_Quote sObjectDomain;
    
    public BECS_QuoteTriggerHandler() {
        this.newOpportunityMap = (Map<Id, Quote>) Trigger.newMap;
        this.sObjectDomain = new BECS_Quote(records);
    }
    
    public override void afterUpdate() {
        sObjectDomain.onAfterUpdate(newOpportunityMap);
    }
}