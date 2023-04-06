@isTest
public class BECS_ModeloTest {
    @TestSetup
    static void makeData(){
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
    static void crearModelo(){
        Map<String, String> modelosNameByCodModelo = new Map<String, String>();
        Map<String, String> marcaCodByCodModelo = new Map<String, String>();
        //Modelo que existe
        modelosNameByCodModelo.put('X10', 'X10');
        marcaCodByCodModelo.put('X10', 'bmw10');
        //modelo que no existe para crearlo
        modelosNameByCodModelo.put('X6', 'X6');
        marcaCodByCodModelo.put('X6', 'bmw10');
        Test.startTest();
        BECS_Modelo createModelo = new BECS_Modelo(new List<HDI4I_Modelo__c>());
        Map<String, HDI4I_Modelo__c> modelosByCod = createModelo.crearModelos(modelosNameByCodModelo, marcaCodByCodModelo);       
        System.assertEquals(2, modelosByCod.keySet().size(), 'Crear');
        Test.stopTest();
    }   
    @IsTest
    static void selectModelo(){
        Map<String, String> modelosNameByCodModelo = new Map<String, String>();
        Map<String, String> marcaCodByCodModelo = new Map<String, String>();
        modelosNameByCodModelo.put('X10', 'X10');
        marcaCodByCodModelo.put('X10', 'bmw10');
        Test.startTest();
        BECS_Modelo createModelo = new BECS_Modelo(new List<HDI4I_Modelo__c>());
        Map<String, HDI4I_Modelo__c> modelosByCod = createModelo.crearModelos(modelosNameByCodModelo, marcaCodByCodModelo);       
        System.assertEquals(1, modelosByCod.keySet().size(), 'Select');
        Test.stopTest();
    }   
}