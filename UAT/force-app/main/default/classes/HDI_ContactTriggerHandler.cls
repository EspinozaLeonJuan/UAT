public with sharing class HDI_ContactTriggerHandler  extends TriggerHandler{

    private Map<Id, Contact> newOppMap;
    private HDI_Contacts sObjectDomain;
    
    public HDI_ContactTriggerHandler() {
        this.newOppMap = (Map<Id, Contact>) Trigger.newMap;
        this.sObjectDomain = new HDI_Contacts(records);
    }
    
    public override void afterInsert() {
        sObjectDomain.onAfterInsert();
    }

    public override void afterUpdate() {
        sObjectDomain.onAfterUpdate(newOppMap);
    }
}