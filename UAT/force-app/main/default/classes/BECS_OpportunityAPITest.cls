@isTest
public class BECS_OpportunityAPITest {
    
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

    }

    @IsTest
    static void testAPISuccess(){
        User IntegradorInstallCall = [Select userName From User Where IntegradorInstantCall__c = True Limit 1];

        List<Campaign> listCampaing = [Select BECS_IdCampanaCotizadorWeb__c From Campaign Limit 1];
        List<Account> listAccount = [Select HDI4I_RUT_del_cliente__c From Account Limit 1];
        System.debug('BECS_OpportunityAPITest ' + listAccount);

        list<BECS_OpportunityAPI.InParameters> jsonToTest = new list<BECS_OpportunityAPI.InParameters>();
        
        BECS_OpportunityAPI.InParameters newOpp = new BECS_OpportunityAPI.InParameters();
        newOpp.nombreCliente = '[web_16842254]';
        newOpp.apellidoPaterno = '[web_16842254]';
        newOpp.campaniaCotizadorWeb = listCampaing[0].BECS_IdCampanaCotizadorWeb__c;
        newOpp.duenioVehiculo = 'No';
        newOpp.deducible = '';
        newOpp.autoReemplazo = '';
        newOpp.productoSeleccionado = '709460000';
        newOpp.tipoVehiculo = 'Moto';
        newOpp.emailCliente = 'desarrollo@dparadig.cl';
        newOpp.descripcionMarcaVehiculo = 'CHEVROLET';
        newOpp.descripcionModeloVehiculo = 'AVEO';
        newOpp.digitoVerificadorRutCliente = '8';
        newOpp.digitoVerificadorRutDuenioVeh = '7';
        newOpp.esVehiculoNuevoOp = 'Sí';
        newOpp.fechaEnvioCotizacion = date.valueOf('2022-05-03');
        newOpp.idHdiOpWeb = '2022_16842254_CHEVROLET_AVEO_2027';
        newOpp.oportunidadGestionada = 'No';
        newOpp.pasoCotizacionWeb = 'Cotizar';
        newOpp.patenteVehiculo = '';
        newOpp.primaCotizacionVehiculo = '';
        newOpp.rutCliente = listAccount[0].HDI4I_RUT_del_cliente__c + '2';
        newOpp.rutDuenioVehiculo = listAccount[0].HDI4I_RUT_del_cliente__c;
        newOpp.telefonoCliente = '223232323';
        newOpp.vehiculoTienePatenteOp = 'Si';
        newOpp.anioVehiculo = '2022';
        newOpp.resposabilidadCivilOp = '';
        newOpp.idMarcaVehiculo = '290';
        newOpp.idModeloVehiculo = '290004';
        newOpp.tipoDePagoOp = 'Pago contado';
        newOpp.pagoPrimeraCuota = '';
        newOpp.prioridad = '1';
        newOpp.origenProspectoOp = '';
        newOpp.IdTarifa = '';
        newOpp.codigoProductoElegido = '';
        newOpp.chasis = '';
        newOpp.numMotor = '';
        newOpp.banco = '';
        newOpp.tipoTarjeta = '0';
        newOpp.numeroTarjeta = '123';
        newOpp.sucursal = '';
        newOpp.numeroCuenta = '321';
        newOpp.numTransaccion = '';
        newOpp.diaCargo = '05';
        newOpp.numeroSimulacion = '24174493';
        jsonToTest.add(newOpp);

        String myJSON = JSON.serialize(jsonToTest);
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/v2/opportunity';
        request.httpMethod = 'POST';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf(myJSON);
        RestContext.request = request;

        Test.startTest();
            System.runAs(IntegradorInstallCall){
                BECS_OpportunityAPI.create();
                HDI4I_RoundRobin_Crono.crono();

                SchedulableContext sc = null;
                HDI4I_Asignacion_crono tsc = new HDI4I_Asignacion_crono();
                tsc.execute(sc);
            }
        Test.stopTest();

    }

    @IsTest
    static void testAPINoData(){
        list<BECS_OpportunityAPI.InParameters> jsonToTest = new list<BECS_OpportunityAPI.InParameters>();
        
        String myJSON = JSON.serialize(jsonToTest);
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/v2/opportunity';
        request.httpMethod = 'POST';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf(myJSON);
        RestContext.request = request;

        Test.startTest();
            BECS_OpportunityAPI.create();
        Test.stopTest();

    }

}