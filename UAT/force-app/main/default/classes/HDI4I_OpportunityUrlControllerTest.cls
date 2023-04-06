@isTest
public class HDI4I_OpportunityUrlControllerTest {
    @TestSetup
    static void makeData(){
        User us = [SELECT Id, UserName FROM User WHERE IntegradorInstantCall__c = TRUE LIMIT 1];
        Profile pf = [SELECT Id FROM Profile WHERE Name = 'Ejecutiva Call Center']; 

        Account acc = new Account();
        acc.LastName = 'Test';
        insert acc;

        Opportunity opp = new Opportunity();
        opp.AccountId = acc.Id;
        opp.Name = 'Test data';
        opp.OwnerId = us.Id;
        opp.StageName = 'Nuevo';
        opp.HDI4I_Id_Oportunidad_web__c = 'TEST_V1_2022'; 
        opp.HDI4I_Campana_cotizador_web__c = 'Campaña Ejecutivo Banco Estado';
        opp.CloseDate = Date.today().addDays(10);
        opp.BECS_FechadeAsignacion__c = System.now().date();
        opp.HDI4I_Asignado_Pull__c = true;
        opp.HDI4I_Patente_del_vehiculo__c = 'testPatente';
        opp.HDI4I_Vehiculo_nuevo__c = 'Sí';
        opp.HDI4I_Tipo_de_vehiculo__c = 'Camioneta';
        insert opp;

        Opportunity opp1 = new Opportunity();
        opp1.AccountId = acc.Id;
        opp1.Name = 'Test data V2';
        opp1.OwnerId = us.Id;
        opp1.StageName = 'Nuevo';
        opp1.HDI4I_Id_Oportunidad_web__c = 'TEST_V2_2022'; 
        opp1.HDI4I_Campana_cotizador_web__c = 'Test Campaña';
        opp1.CloseDate = Date.today().addDays(10);
        opp1.BECS_FechadeAsignacion__c = System.now().date();
        opp1.HDI4I_Asignado_Pull__c = true;
        opp1.HDI4I_Patente_del_vehiculo__c = 'testPatente';
        opp1.HDI4I_Vehiculo_nuevo__c = 'No';
        opp1.HDI4I_Tipo_de_vehiculo__c = 'Moto';
        opp1.HDI4I_RUT_del_cliente__c = '75465645';
        opp1.HDI4I_RUT_dueno_del_vehiculo__c = '1654531';
        insert opp1;

        Opportunity opp2 = new Opportunity();
        opp2.AccountId = acc.Id;
        opp2.Name = 'Test data V3';
        opp2.OwnerId = us.Id;
        opp2.StageName = 'Nuevo';
        opp2.HDI4I_Id_Oportunidad_web__c = 'TEST_V3_2022'; 
        opp2.HDI4I_Campana_cotizador_web__c = 'Test Campaña';
        opp2.CloseDate = Date.today().addDays(10);
        opp2.BECS_FechadeAsignacion__c = System.now().date();
        opp2.HDI4I_Asignado_Pull__c = true;
        opp2.HDI4I_Patente_del_vehiculo__c = 'testPatente';
        opp2.HDI4I_Vehiculo_nuevo__c = 'No';
        opp2.HDI4I_Tipo_de_vehiculo__c = 'Carro de arrastre';
        opp2.HDI4I_RUT_del_cliente__c = '75465645';
        opp2.HDI4I_RUT_dueno_del_vehiculo__c = '1654531';
        insert opp2;
    }
    static testMethod void testClass() {

        HDI4I_UrlCall.mock = new HDI4I_MockHttpCotizador();
        String userId = '';
        List<User> usuario = [SELECT Id FROM User WHERE IntegradorInstantCall__c = true LIMIT 1];
        if(!usuario.isEmpty()){
            userId = usuario[0].Id;
        }
        List<Opportunity> opp = [SELECT Id, HDI4I_Id_Oportunidad_web__c, Owner.name, CreatedDate, OwnerId, Stagename, BECS_FechadeAsignacion__c
                                 FROM Opportunity WHERE OwnerId =: usuario[0].Id AND stagename = 'Nuevo' AND HDI4I_Id_Oportunidad_web__c != null limit 3];
        
        
        System.debug(opp);


        Test.startTest();
            PageReference pagina = page.HDI4I_CotizadorOp;
            ApexPages.StandardController sc = new ApexPages.StandardController(opp[0]);
            Test.setCurrentPage(pagina);
            ApexPages.currentPage().getParameters().put('id',opp[0].id);
            HDI4I_OpportunityUrlController con = new HDI4I_OpportunityUrlController(sc);
            System.assertEquals(null,con.updateOpp());
            System.assertEquals(con.getId, opp[0].Id);
            
            ApexPages.currentPage().getParameters().put('id',opp[1].id);
            ApexPages.StandardController co = new ApexPages.StandardController(opp[1]);
            HDI4I_OpportunityUrlController con1 = new HDI4I_OpportunityUrlController(co);
            System.assertEquals(con1.getId, opp[1].Id);

            ApexPages.currentPage().getParameters().put('id',opp[2].id);
            ApexPages.StandardController cod = new ApexPages.StandardController(opp[2]);
            HDI4I_OpportunityUrlController con2 = new HDI4I_OpportunityUrlController(cod);
            System.assertEquals(con2.getId, opp[2].Id);
        Test.stopTest();

    }
}