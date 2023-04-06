trigger HDI_ContactTrigger on Contact (before insert, after insert, before update, after update) {
    new HDI_ContactTriggerHandler().run();
}