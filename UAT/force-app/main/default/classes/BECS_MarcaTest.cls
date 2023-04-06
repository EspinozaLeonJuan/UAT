@isTest
public class BECS_MarcaTest {
    @TestSetup
    static void makeData(){
        /*HDI4I_Marca__c marca = new HDI4I_Marca__c();        
        marca.Name = 'BMW';
        marca.HDI4I_Codigo_de_la_marca__c  = 'bmw1';*/
		HDI4I_Marca__c marca = BECS_DataFactory.createMarcasConNombre(1, 'BMW', 'bmw1')[0];
		       
        insert marca;
    }
    @IsTest
    static void crearMarca(){
        Map<String, String> marcasNameByCod = new Map<String, String>();
        marcasNameByCod.put('bmw10', 'BMW0');
        marcasNameByCod.put('S2', 'SEAT');
        Test.startTest();
        BECS_Marca createMarcas = new BECS_Marca(new List<HDI4I_Marca__c>());
        Map<String, HDI4I_Marca__c> marcasByCod = createMarcas.crearMarcas(marcasNameByCod);       
        System.assertEquals(2, marcasByCod.keySet().size(), 'Crear');
        Test.stopTest();
    }   
    @IsTest
    static void selectMarca(){
        Map<String, String> marcasNameByCod = new Map<String, String>();
        marcasNameByCod.put('bmw1', 'BMW');
        Test.startTest();
        BECS_Marca createMarcas = new BECS_Marca(new List<HDI4I_Marca__c>());
        Map<String, HDI4I_Marca__c> marcasByCod = createMarcas.crearMarcas(marcasNameByCod);       
        System.assertEquals(1, marcasByCod.keySet().size(), 'Select');
        Test.stopTest();
    }   
}