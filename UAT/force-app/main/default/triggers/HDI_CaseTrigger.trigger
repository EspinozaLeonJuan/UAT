trigger HDI_CaseTrigger on Case (before insert, after insert, before update, after update) {
    new HDI_CaseTriggerHandler().run();
}