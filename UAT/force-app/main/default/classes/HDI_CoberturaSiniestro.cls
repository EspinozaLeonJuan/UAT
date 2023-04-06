public with sharing class HDI_CoberturaSiniestro extends fflib_SObjectDomain{
    private static final List<Schema.SObjectType> SERVICE_SOBJECTS = new Schema.SObjectType[] { HDI4I_Cobertura_del_siniestro__c.SObjectType };

    public HDI_CoberturaSiniestro(List<HDI4I_Cobertura_del_siniestro__c> sObjectList) {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new HDI_CoberturaSiniestro(sObjectList);
        }
    }

    public override void onBeforeInsert() {
        for(HDI4I_Cobertura_del_siniestro__c c: (List<HDI4I_Cobertura_del_siniestro__c>) Records){
            system.debug('Deducible: '+c.HDI4I_Deducible__c);
            system.debug('Provision: '+c.HDI4I_Provision__c);    
        }    
    }

    public override void onAfterInsert() {
        for(HDI4I_Cobertura_del_siniestro__c c: (List<HDI4I_Cobertura_del_siniestro__c>) Records){
            system.debug('Deducible: '+c.id);
            system.debug('Deducible: '+c.HDI4I_Deducible__c);
            system.debug('Provision: '+c.HDI4I_Provision__c);
            //HDI4I_SIN_crono_sla.crono_sla(c.HDI4I_Id_de_cobertura__c, 2);    
        }    
    }

    public override void onBeforeUpdate(Map<Id, SObject> sObjectMap) {
        for(HDI4I_Cobertura_del_siniestro__c c: (List<HDI4I_Cobertura_del_siniestro__c>) Records){
            system.debug('Deducible: '+c.id);
            system.debug('Deducible: '+c.HDI4I_Deducible__c);
            system.debug('Provision: '+c.HDI4I_Provision__c);    
        }     
    }
}