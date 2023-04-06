@IsTest
public without sharing class BECS_FinancialAccountTest {
    
    @TestSetup
    static void makeData(){
        List<Account> createPersonAccount = BECS_DataFactory.createPersonAccount(1);
        insert createPersonAccount;

        List<Campaign> createCampaigns = BECS_DataFactory.createCampaigns(1);
        insert createCampaigns;

        Profile perfil = [Select id From Profile where Name = 'Ejecutiva Call Center'];
        List<User> createUsers = BECS_DataFactory.createUsers(1, perfil.id);
        insert createUsers;
        createUsers = [Select id From User Where Profile.Name = 'Ejecutiva Call Center'];

        List<HDI4I_Estado_ejecutivas_call_center__c> createEstadoEjecutivasCallCenter = BECS_DataFactory.createEstadoEjecutivasCallCenter(createUsers);
        insert createEstadoEjecutivasCallCenter;

        Map<String,Schema.RecordTypeInfo> recordtypeMap = Schema.getGlobalDescribe().get('FinServ__FinancialAccount__c').getDescribe().getRecordTypeInfosByDeveloperName();
        id idInsurancePolicy = recordtypeMap.get('InsurancePolicy').getRecordTypeId();

        FinServ__FinancialAccount__c financialA = new FinServ__FinancialAccount__c();
        financialA.RecordTypeId = idInsurancePolicy;
        financialA.FinServ__PrimaryOwner__c = createPersonAccount[0].Id;
        financialA.Name = 'Test Financial';
        insert financialA;

        Opportunity op = new Opportunity();
        op.Name='2022_16842254_CHEVROLET_AVEO_2027';
        op.StageName='Nuevo'; 
        op.LeadSource=''; 
        op.HDI4I_Origen_de_la_oportunidad__c='VSV2'; 
        op.CurrencyIsoCode='CLF';
        op.AccountId = createPersonAccount[0].Id;
        op.BECS_Asegurado__c= createPersonAccount[0].Id;
        op.BECS_Contratante__c= createPersonAccount[0].Id;
        op.CampaignId= createCampaigns[0].id;
        op.CloseDate= date.today() + 9;
        //op.BECS_DatosBancarios__c='a0F7V00000VQSqDUAX'; 
        op.HDI4I_Campana_cotizador_web__c='12340'; 
        op.HDI4I_Dueno_vehiculo__c='No'; 
        op.HDI4I_Deducible__c=''; 
        op.HDI4I_Auto_reemplazo__c=''; 
        op.HDI4I_Producto_seleccionado__c='709460000'; 
        op.HDI4I_Tipo_de_vehiculo__c='Moto';
        op.HDI4I_Correo_asegurado__c='desarrollo@dparadig.cl'; 
        op.HDI4I_Marca__c='CHEVROLET'; 
        op.HDI4I_Modelo__c='AVEO'; 
        op.HDI4I_Digito_verificador_rut_cliente__c='8'; 
        op.HDI4I_Digito_verif_rut_dueno_vehiculo__c='7'; 
        op.HDI4I_Vehiculo_nuevo__c='Sí'; 
        op.HDI4I_Fecha_envio_cotizacion__c= system.now(); 
        op.HDI4I_Id_Oportunidad_web__c='2022_16842254_CHEVROLET_AVEO_2057'; 
        op.HDI4I_Oportunidad_gestionada__c='No'; 
        op.HDI4I_Paso_cotizacion_web__c='Cotizar'; 
        op.HDI4I_Patente_del_vehiculo__c=''; 
        op.HDI4I_Prima_cotizo_seguro__c=''; 
        op.HDI4I_RUT_del_cliente__c='249902'; 
        op.HDI4I_RUT_dueno_del_vehiculo__c='24990'; 
        op.HDI4I_Numero_contacto__c='223232323'; 
        op.HDI4I_Vehiculo_tiene_patente__c='Si'; 
        op.HDI4I_Ano_del_vehiculo__c='2022'; 
        op.HDI4I_Responsabilidad_civil__c=''; 
        op.HDI4I_Id_Marca_vehiculo__c='290'; 
        op.HDI4I_Id_Modelo_vehiculo__c='290004'; 
        op.HDI4I_Tipo_de_pago__c='Pago contado'; 
        op.HDI4I_Pago_primera_cuota__c=''; 
        op.HDI4I_Prioridad__c='1'; 
        op.HDI4I_IdTarifa__c=''; 
        op.HDI4I_Codigo_de_producto_elegido__c=''; 
        op.HDI4I_Numero_chasis__c=''; 
        op.HDI4I_Numero_motor__c=''; 
        op.HDI4I_Banco__c='';
        op.HDI4I_Tipo_tarjeta__c='0';
        op.HDI4I_Numero_tarjeta__c='123'; 
        op.HDI4I_Sucursal__c='';
        op.HDI4I_Numero_cuenta__c='321';
        op.HDI4I_Numero_transaccion__c=''; 
        op.HDI4I_Dia_cargo__c='05';
        op.BECS_NumeroSimulacion__c='24174493';
        op.FinServ__FinancialAccount__c = financialA.id;
        insert op;

    }

    @IsTest
    static void methodName(){
        
        Test.startTest();
            Opportunity opo = [Select FinServ__FinancialAccount__c from Opportunity Limit 1];

            FinServ__FinancialAccount__c financialAccount = [Select id from FinServ__FinancialAccount__c Where id =: opo.FinServ__FinancialAccount__c Limit 1];
            financialAccount.BECS_UltimaPolizaGenerada__c = '12345';
            update financialAccount;
        Test.stopTest();
        
    }

}