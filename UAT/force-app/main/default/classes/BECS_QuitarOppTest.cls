@isTest
public class BECS_QuitarOppTest {
    private static String CRON_EXP = '0 0 0 3 9 ? 2022';

    @TestSetup
    static void makeData(){
        User us = [SELECT Id, UserName FROM User WHERE IntegradorInstantCall__c = TRUE LIMIT 1];
        Profile pf = [SELECT Id FROM Profile WHERE Name = 'Ejecutiva Call Center']; 

        User us1 = new User();
        us1.Username = 'executive@hdi.cl';
        us1.Alias = 'RRtest1';
        us1.LastName = 'Test1';
        us1.Email = 'executive@hdi.cl';
        us1.TimeZoneSidKey = 'America/Los_Angeles';
        us1.LocaleSidKey = 'en_US';
        us1.EmailEncodingKey = 'UTF-8';
        us1.ProfileId = pf.Id;
        us1.LanguageLocaleKey = 'en_US';
        insert us1;

        User us2 = new User();
        us2.Username = 'executive1@hdi.cl';
        us2.Alias = 'RRtest2';
        us2.LastName = 'Test2';
        us2.Email = 'executive2@hdi.cl';
        us2.TimeZoneSidKey = 'America/Los_Angeles';
        us2.LocaleSidKey = 'en_US';
        us2.EmailEncodingKey = 'UTF-8';
        us2.ProfileId = pf.Id;
        us2.LanguageLocaleKey = 'en_US';
        insert us2;

        Account acc = new Account();
        acc.LastName = 'Test';
        insert acc;

        Opportunity opp = new Opportunity();
        opp.AccountId = acc.Id;
        opp.Name = 'Test data';
        opp.OwnerId = us1.Id;
        opp.StageName = 'Nuevo';
        opp.HDI4I_Id_Oportunidad_web__c = 'TEST_V1_2022'; 
        opp.HDI4I_Campana_cotizador_web__c = 'Campaña Ejecutivo Banco Estado';
        opp.CloseDate = Date.today().addDays(10);
        opp.BECS_FechadeAsignacion__c = System.now().date();
        opp.HDI4I_Asignado_Pull__c = true;
        insert opp;

        Opportunity opp1 = new Opportunity();
        opp1.AccountId = acc.Id;
        opp1.Name = 'Test data V2';
        opp1.OwnerId = us2.Id;
        opp1.StageName = 'Nuevo';
        opp1.HDI4I_Id_Oportunidad_web__c = 'TEST_V2_2022'; 
        opp1.HDI4I_Campana_cotizador_web__c = 'Test Campaña';
        opp1.CloseDate = Date.today().addDays(10);
        opp1.BECS_FechadeAsignacion__c = System.now().date();
        opp1.HDI4I_Asignado_Pull__c = true;
        insert opp1;

        HDI4I_Mantenedor_ejecutiva__c executive = new HDI4I_Mantenedor_ejecutiva__c();
        executive.OwnerId = us1.Id;
        insert executive;

        HDI4I_Estado_ejecutivas_call_center__c call = new HDI4I_Estado_ejecutivas_call_center__c();
        call.HDI4I_Asignacion__c = true;
        call.HDI4I_Ejecutiva__c = us1.Id; 
        call.HDI4I_Cantidad__c = 2; 
        call.HDI4I_Porcentaje_asignacion__c = 125;
        call.HDI_Campana__c = 'Banco Estado';
        call.HDI4I_On_Off__c = false; 
        call.HDI4I_Ejecutivas_Call_Center__c = executive.Id;
        insert call;

        HDI4I_Estado_ejecutivas_call_center__c call1 = new HDI4I_Estado_ejecutivas_call_center__c();
        call1.HDI4I_Asignacion__c = true;
        call1.HDI4I_Ejecutiva__c = us2.Id; 
        call1.HDI4I_Cantidad__c = 2; 
        call1.HDI4I_Porcentaje_asignacion__c = 5;
        call1.HDI_Campana__c = 'Ecommerce';
        call1.HDI4I_On_Off__c = false; 
        call1.HDI4I_Ejecutivas_Call_Center__c = executive.Id;
        insert call1;
    }

    static testmethod void test() {
        Test.startTest();
            String jobId = System.schedule('Test HDI4I_QuitarOpp', CRON_EXP, new HDI4I_QuitarOpp());
     
            CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id =: jobId];

            System.assertEquals(CRON_EXP, ct.CronExpression);
            System.assertEquals(0, ct.TimesTriggered);
        Test.stopTest();
    }
}