public without sharing class HDI_TaskTriggerHandler extends TriggerHandler{

    private Map<Id, Task> newOppMap;
    private HDI_Tasks sObjectDomain;
    
    public HDI_TaskTriggerHandler() {
        this.newOppMap = (Map<Id, Task>) Trigger.newMap;
        this.sObjectDomain = new HDI_Tasks(records);
    }
    
    public override void beforeInsert() {
        sObjectDomain.onBeforeInsert();
    }

}