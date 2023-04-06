@isTest
public class BECS_QuoteTest {
    
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

        Profile perfil = [Select id From Profile where Name = 'Ejecutiva Call Center'];
        List<User> createUsers = BECS_DataFactory.createUsers(1, perfil.id);
        insert createUsers;
        createUsers = [Select id From User Where Profile.Name = 'Ejecutiva Call Center'];

        List<HDI4I_Estado_ejecutivas_call_center__c> createEstadoEjecutivasCallCenter = BECS_DataFactory.createEstadoEjecutivasCallCenter(createUsers);
        insert createEstadoEjecutivasCallCenter;

        Map< String, List<sObject> > oppos = BECS_DataFactory.createOpportunities(1, createPersonAccount[0], createMarcas[0], modelo);
        insert oppos.get('opportunities');
    }

    @IsTest
    static void testQuote(){
        User IntegradorInstallCall = [Select userName From User Where IntegradorInstantCall__c = True Limit 1];
        
        Opportunity opp = [Select AccountId, Account.PersonContactId From Opportunity limit 1];
        opp.OwnerId = IntegradorInstallCall.id;
        update opp;

        test.startTest();
            Quote cotizacion = new Quote(OpportunityId = opp.id, Name = 'Testing quote', Email = 'test@hdi.com', ContactId = opp.Account.PersonContactId);
            insert cotizacion;

            cotizacion.hdi4i_ultima_cotizacion_generada__c = 'Testing quote';
            update cotizacion;

            SchedulableContext sc = null;
            //BECS_OpportunityAsignacionPull tsc = new BECS_OpportunityAsignacionPull();
            //tsc.execute(sc);

        Test.stopTest();

    }
}