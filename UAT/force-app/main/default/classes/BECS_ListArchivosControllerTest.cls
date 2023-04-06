@isTest
public with sharing class BECS_ListArchivosControllerTest {
    
    @TestSetup
    static void makeData(){
        List<Account> createPersonAccount = BECS_DataFactory.createPersonAccount(1);
        insert createPersonAccount;

        List<Campaign> createCampaigns = BECS_DataFactory.createCampaigns(1);
        insert createCampaigns;

        List<HDI4I_Marca__c> createMarcas = BECS_DataFactory.createMarcas(1);
        insert createMarcas;

        Map< String, List<sObject> > createModelos = BECS_DataFactory.createModelos(1, createMarcas[0]);
        insert createModelos.get('modelos');

        HDI4I_Modelo__c modelo = [Select HDI4I_Codigo_del_modelo__c From HDI4I_Modelo__c limit 1];


        Map< String, List<sObject> > oppos = BECS_DataFactory.createOpportunities(1, createPersonAccount[0], createMarcas[0], modelo);
        insert oppos.get('opportunities');
    }

    @IsTest
    static void testQuote(){
        Opportunity opp = [Select AccountId, Account.PersonContactId From Opportunity limit 1];

        test.startTest();
            BECS_ListArchivosController.getListArchivos(opp.Id);
        Test.stopTest();

    }
}