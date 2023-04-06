public with sharing class HDI_CoberturaSiniestroTriggerHandler extends TriggerHandler{

    private Map<Id, HDI4I_Cobertura_del_siniestro__c> newOppMap;
    private HDI_CoberturaSiniestro sObjectDomain;
    
    public HDI_CoberturaSiniestroTriggerHandler() {
        this.newOppMap = (Map<Id, HDI4I_Cobertura_del_siniestro__c>) Trigger.newMap;
        this.sObjectDomain = new HDI_CoberturaSiniestro(records);
    }
    
    public override void beforeInsert() {
        sObjectDomain.onBeforeInsert();
    }

    public override void afterInsert() {
        sObjectDomain.onAfterInsert();
    }

    public override void beforeUpdate() {
        sObjectDomain.onBeforeUpdate(newOppMap);
    }
    
}