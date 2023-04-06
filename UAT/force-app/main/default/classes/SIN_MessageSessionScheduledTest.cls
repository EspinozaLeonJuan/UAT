@isTest
public with sharing class SIN_MessageSessionScheduledTest {

    @IsTest
    static void mensajeTopeConversaciones(){
        
        Test.startTest();
            SIN_MessageSessionScheduled.crono();
        Test.stopTest();
        
    }
}