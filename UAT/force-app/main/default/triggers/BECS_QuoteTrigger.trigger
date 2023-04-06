trigger BECS_QuoteTrigger on Quote (before insert, after insert, before update, after update) {
    new BECS_QuoteTriggerHandler().run();

}