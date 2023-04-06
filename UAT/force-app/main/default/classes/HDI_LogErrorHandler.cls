public with sharing class HDI_LogErrorHandler extends TriggerHandler {
    List<ORG_IntegrationLogError__c> newList = Trigger.new;
    //List<ORG_IntegrationLogError__c> oldList = Trigger.Old;
    //Map<Id, ORG_IntegrationLogError__c> newMap = ((Map<Id, ORG_IntegrationLogError__c>)(Trigger.NewMap));
    //Map<Id, ORG_IntegrationLogError__c> oldMap = ((Map<Id, ORG_IntegrationLogError__c>)(Trigger.OldMap));

    public override void beforeUpdate() {
        HDI_LogErrorTL.retryCreateOpportunity(newList);
    }
}