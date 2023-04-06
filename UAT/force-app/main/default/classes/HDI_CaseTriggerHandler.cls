public without sharing class HDI_CaseTriggerHandler extends TriggerHandler{

        private Map<Id, Case> newOppMap;
        private HDI_Cases sObjectDomain;
        
        public HDI_CaseTriggerHandler() {
            this.newOppMap = (Map<Id, Case>) Trigger.newMap;
            this.sObjectDomain = new HDI_Cases(records);
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

        public override void afterUpdate() {
            sObjectDomain.onAfterUpdate(newOppMap);
        }
}