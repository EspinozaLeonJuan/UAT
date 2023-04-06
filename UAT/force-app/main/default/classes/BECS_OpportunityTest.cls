@isTest
public class BECS_OpportunityTest {
    @TestSetup
    static void makeData(){
        Account acc = BECS_DataFactory.createAccounts(1)[0];
        acc.LastName = 'Test';
        insert acc;
        
        /*HDI4I_Marca__c marca = new HDI4I_Marca__c();        
        marca.Name = 'BMW';
        marca.HDI4I_Codigo_de_la_marca__c  = 'bmw1';*/
		HDI4I_Marca__c marca = BECS_DataFactory.createMarcasConNombre(1, 'BMW', 'bmw1')[0];
		       
        insert marca;
        
        /*HDI4I_Modelo__c modelo = new HDI4I_Modelo__c();
        modelo.Name = 'X1';
        modelo.HDI4I_Codigo_del_modelo__c = 'X1';
        modelo.HDI4I_Marca__c = marca.id;       */
        HDI4I_Modelo__c modelo = (HDI4I_Modelo__c)BECS_DataFactory.createModelosConNombre(1,marca,'X1','X1').get('modelos')[0];
        insert modelo;
    }
    @IsTest
    static void opp1(){
        /*Opportunity opp = new Opportunity();
        opp.AccountId =  [Select id From Account Limit 1].Id;
        opp.Name = 'Test data';
        opp.StageName = 'Nuevo';
        opp.HDI4I_Id_Oportunidad_web__c = 'TEST_V1_2022'; 
        opp.HDI4I_Campana_cotizador_web__c = 'Campaña Ejecutivo Banco Estado';
        opp.CloseDate = Date.today().addDays(10);
        opp.HDI4I_Asignado_Pull__c = true; 
        opp.LeadSource = 'VSV2';
        opp.HDI4I_Id_Marca_vehiculo__c = [Select id, HDI4I_Codigo_de_la_marca__c From HDI4I_Marca__c Limit 1].HDI4I_Codigo_de_la_marca__c;
        opp.HDI4I_Id_Modelo_vehiculo__c = [Select id, HDI4I_Codigo_del_modelo__c From HDI4I_Modelo__c Limit 1].HDI4I_Codigo_del_modelo__c;*/
        Opportunity opp =(Opportunity) BECS_DataFactory.createOpportunities(1,[Select id From Account Limit 1][0],
                                                               [Select id, HDI4I_Codigo_de_la_marca__c From HDI4I_Marca__c Limit 1][0],
                                                               [Select id, HDI4I_Codigo_del_modelo__c From HDI4I_Modelo__c Limit 1][0]).get('opportunities')[0];
        
        
        
        

        Test.startTest();
        System.debug(opp);
        insert opp;    
        
        opp = [Select id, HDI4I_Marca_objeto__c, HDI4I_Modelo_objeto__c from Opportunity];
        System.debug(opp);
        system.assertEquals([Select id From HDI4I_Marca__c Limit 1][0].Id, opp.HDI4I_Marca_objeto__c, 'Marca ');
        system.assertEquals([Select id From HDI4I_Modelo__c Limit 1][0].Id, opp.HDI4I_Modelo_objeto__c, 'Modelo ');
        Test.stopTest();
        
    }
    
    
}