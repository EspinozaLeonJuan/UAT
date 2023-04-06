@isTest
public without sharing class HDI_Task_Test {
    
    @TestSetup
    static void makeData(){
        Account acc = new Account();
        acc.LastName = 'Test';
        insert acc;

        Opportunity opp = new Opportunity();
        opp.AccountId = acc.Id;
        opp.Name = 'Test data';
        opp.StageName = 'Nuevo';
        opp.HDI4I_Id_Oportunidad_web__c = 'TEST_V1_2022'; 
        opp.HDI4I_Campana_cotizador_web__c = 'Campaña Ejecutivo Banco Estado';
        opp.CloseDate = Date.today().addDays(10);
        opp.HDI4I_Asignado_Pull__c = true;
        insert opp;    
    }

    @IsTest
    static void task1(){
        Task tarea = new Task();
        tarea.BECS_Oportunidad__c = [Select id From Opportunity Limit 1].Id;
        tarea.Subject = 'Llamada Test';
        tarea.BECS_UltimaLlamada__c = true;

        Test.startTest();
            insert tarea;
            System.debug(tarea);
            system.assertEquals(true, tarea.BECS_UltimaLlamada__c, 'Correcto ');
        Test.stopTest();
        
    }
}