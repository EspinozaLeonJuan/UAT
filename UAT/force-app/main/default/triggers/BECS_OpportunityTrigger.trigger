trigger BECS_OpportunityTrigger on Opportunity (before insert, after insert, before update, after update) {
    new BECS_OpportunityTriggerHandler().run();
}