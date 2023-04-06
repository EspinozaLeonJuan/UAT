public without sharing class BECS_OpportunityTriggerHandler extends TriggerHandler{
    private Map<Id, Opportunity> newOpportunityMap;
    private BECS_Opportunity sObjectDomain;
    
    public BECS_OpportunityTriggerHandler() {
        this.newOpportunityMap = (Map<Id, Opportunity>) Trigger.newMap;
        this.sObjectDomain = new BECS_Opportunity(records);
    }
    
    public override void beforeInsert() {
        sObjectDomain.onBeforeInsert();
    }
    
    public override void afterInsert() {
        sObjectDomain.onAfterInsert();
    }
    
    public override void beforeUpdate() {
        sObjectDomain.onBeforeUpdate(newOpportunityMap);
    }
    
    public override void afterUpdate() {
        sObjectDomain.onAfterUpdate(newOpportunityMap);
    }
}