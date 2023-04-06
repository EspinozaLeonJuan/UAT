@isTest
public class HDI_LogErroresBatchTest {
    
    @TestSetup
    static void makeData(){
        List<ORG_IntegrationLogError__c> errorLogList = new List<ORG_IntegrationLogError__c>();
        errorLogList.add(new ORG_IntegrationLogError__c(Name = 'WS_POST : Error', ORG_FechaHoraError__c = DateTime.now(), ORG_Proyecto__c = 'Instant Call',
        ORG_DescriptionError__c = 'Invalid format: "" at [line:17, column:34]', ORG_Estado__c = 'No procesado', ORG_Solicitud__c = getJsonError()));
        errorLogList.add(new ORG_IntegrationLogError__c(Name = 'WS_PUT : Error', ORG_FechaHoraError__c = DateTime.now(), ORG_Proyecto__c = 'Instant Call',
        ORG_DescriptionError__c = 'Invalid format: "" at [line:17, column:34]', ORG_Estado__c = 'No procesado', ORG_Solicitud__c = getJsonError()));
        errorLogList.add(new ORG_IntegrationLogError__c(Name = 'WS : Error', ORG_FechaHoraError__c = DateTime.now(), ORG_Proyecto__c = 'Instant Call',
        ORG_DescriptionError__c = 'Invalid format: "" at [line:17, column:34]', ORG_Estado__c = 'No procesado', ORG_Solicitud__c = getJsonError()));

        if(!errorLogList.isEmpty()){
            insert errorLogList;
        }
    }

    @isTest
    static void testBatch(){
        Test.startTest();
            ID batchprocessid = Database.executeBatch(new HDI_LogErroresBatch(), 5);
        Test.stopTest();
    }

    private static String getJsonError(){
        String result = '';
        result += '{"idCuenta": "0016s00000SBc1fAAD","nombreCliente": "Test v1","apellidoPaterno": "Last name","campaniaCotizadorWeb": "Test campaniaCotizadorWeb","duenioVehiculo": "No","deducible": "709460000",';
        result += '"autoReemplazo": "709460000","productoSeleccionado": "709460000","tipoVehiculo": "709460000","emailCliente": "","direccionCliente": "","descripcionMarcaVehiculo": "","descripcionModeloVehiculo": "",';
        result += '"digitoVerificadorRutCliente": "","digitoVerificadorRutDuenioVeh": "","esVehiculoNuevoOp": "709460000","fechaEnvioCotizacion": "","idHdiOpWeb": "HDI4I_Id_Oportunidad_web__c4",';
        result += '"oportunidadGestionada": "","pasoCotizacionWeb": "10","patenteVehiculo": "","primaCotizacionVehiculo": "","rutCliente": "15479853","rutDuenioVehiculo": "15479853","telefonoCliente": "",';
        result += '"vehiculoTienePatenteOp": "","anioVehiculo": "","resposabilidadCivilOp": "709460000","idMarcaVehiculo": "","idModeloVehiculo": "","tipoDePagoOp": "709460000","pagoPrimeraCuota": "709460000",';
        result += '"prioridad": "","origenProspectoOp": "752230001","UTMGoogle": "","IdTarifa": "","codigoProductoElegido": "","chasis": "","numMotor": "","banco": "","tipoTarjeta": "","numeroTarjeta": "","sucursal": "",';
        result += '"numeroCuenta": "","numTransaccion": "","diaCargo": "","tipoEnvio": ""}';
        return result;
    }
}