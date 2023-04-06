trigger HDI_CoberturaSiniestroTrigger on HDI4I_Cobertura_del_siniestro__c (before insert, after insert, before update, after update) {
    new HDI_CoberturaSiniestroTriggerHandler().run(); 
}