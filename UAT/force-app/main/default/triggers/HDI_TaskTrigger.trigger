trigger HDI_TaskTrigger on Task (before insert, after insert, before update, after update) {
    new HDI_TaskTriggerHandler().run();
}