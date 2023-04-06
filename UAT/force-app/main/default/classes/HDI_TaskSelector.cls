public without sharing class HDI_TaskSelector extends fflib_SObjectSelector{
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Task.Id,
            Task.BECS_Oportunidad__c,
            Task.BECS_UltimaLlamada__c
        };
    }

    public Schema.SObjectType getSObjectType() {
        return Task.sObjectType;
    }
    

    public List<Task> selectByOpportunity(Set<String> listOpportunityId) {
        return (List<Task>) Database.query(
            newQueryFactory().
            setCondition('BECS_UltimaLlamada__c = True AND BECS_Oportunidad__c IN: listOpportunityId').
            toSOQL()
        );
    }

}