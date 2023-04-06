@isTest(SeeAllData=true)
public class MarcaModeloTest {
    
    static testMethod void Post1(){
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/create/';  
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueof(j());
        RestContext.request = req;
        RestContext.response = res;
        ApiHDI.create();
        
        RestRequest req0 = new RestRequest(); 
        RestResponse res0 = new RestResponse();
        
        req0.requestURI = '/services/apexrest/create/';  
        req0.httpMethod = 'POST';
        req0.requestBody = Blob.valueof(j1());
        RestContext.request = req0;
        RestContext.response = res0;
        ApiHDI.create();
        
        RestRequest req1 = new RestRequest(); 
        RestResponse res1 = new RestResponse();
        
        req1.requestURI = '/services/apexrest/create/';  
        req1.httpMethod = 'POST';
        req1.requestBody = Blob.valueof(j2());
        RestContext.request = req1;
        RestContext.response = res1;
        ApiHDI.create();
    }
    static testMethod void testDoPost4(){
       List<Opportunity> o = [select id, HDI4I_Ultima_propuesta_generada__c from Opportunity where id =: '0063t000010KT1xAAG'];
        o[0].HDI4I_Ultima_propuesta_generada__c = 'Footer_clientes';
        update o; 
    }
    
    public static String j(){
        String g = '{'+
            '"nombreCliente":"[ProsEmailError1]",'+
            '"apellidoPaterno":"[ProsEmailError]",'+
            '"campaniaCotizadorWeb":"Campaña VSV Agosto JGI",'+
            '"duenioVehiculo":"No",'+
            '"pasoCotizacionWeb":"10",'+
            '"prioridad":"1",'+
            '"rutCliente":"15425797",'+
            '"rutDuenioVehiculo":"15425797",'+
            '"digitoVerificadorRutCliente":"7",'+
            '"digitoVerificadorRutDuenioVeh":"7",'+
            '"deducible":"709460001",'+
            '"autoReemplazo":"709460001",'+
            '"resposabilidadCivilOp":"709460001",'+
            '"productoSeleccionado":"709460000",'+
            '"tipoVehiculo":"709460001",'+
            '"emailCliente":"pruebaopel2@prueba.cl",'+
            '"direccionCliente":"",'+
            '"descripcionMarcaVehiculo":"OPEL",'+
            '"descripcionModeloVehiculo":"ANTARA",'+
            '"esVehiculoNuevoOp":"709460001",'+
            '"fechaEnvioCotizacion":"2021-02-01",'+
            '"idHdiOpWeb":"2021_15425797_OPEL_ANTARA_2020",'+
            '"oportunidadGestionada":"No",'+    
            '"patenteVehiculo":"",'+
            '"primaCotizacionVehiculo":"",'+    
            '"telefonoCliente":"999999999",'+
            '"vehiculoTienePatenteOp":"Si",'+
            '"anioVehiculo":"2020",'+    
            '"idMarcaVehiculo":"240",'+
            '"idModeloVehiculo":"240070",'+
            '"tipoDePagoOp":"",'+
            '"pagoPrimeraCuota":"",'+    
            '"origenProspectoOp":"",'+
            '"codigoProductoElegido":"",'+
            '"numMotor":"",'+
            '"chasis":"",'+
            '"banco":"",'+
            '"tipoTarjeta":"",'+
            '"numeroTarjeta":"",'+
            '"sucursal":"",'+
            '"numeroCuenta":"",'+
            '"numTransaccion":"",'+
            '"tipoEnvio":"PUT"'+
            '}';
        return g;
    }
    
    public static String j1(){
        String g = '{'+
            '"nombreCliente":"[ProsEmailError1]",'+
            '"apellidoPaterno":"[ProsEmailError]",'+
            '"campaniaCotizadorWeb":"Campaña VSV Agosto JGI",'+
            '"duenioVehiculo":"No",'+
            '"pasoCotizacionWeb":"10",'+
            '"prioridad":"1",'+
            '"rutCliente":"15425797",'+
            '"rutDuenioVehiculo":"15425797",'+
            '"digitoVerificadorRutCliente":"7",'+
            '"digitoVerificadorRutDuenioVeh":"7",'+
            '"deducible":"709460001",'+
            '"autoReemplazo":"709460001",'+
            '"resposabilidadCivilOp":"709460001",'+
            '"productoSeleccionado":"709460000",'+
            '"tipoVehiculo":"709460001",'+
            '"emailCliente":"pruebaopel2@prueba.cl",'+
            '"direccionCliente":"",'+
            '"descripcionMarcaVehiculo":"OPEL",'+
            '"descripcionModeloVehiculo":"ANTARA",'+
            '"esVehiculoNuevoOp":"709460001",'+
            '"fechaEnvioCotizacion":"2021-02-01",'+
            '"idHdiOpWeb":"2021_15425797_OPEL_ANTARA1_2020",'+
            '"oportunidadGestionada":"No",'+    
            '"patenteVehiculo":"",'+
            '"primaCotizacionVehiculo":"",'+    
            '"telefonoCliente":"999999999",'+
            '"vehiculoTienePatenteOp":"Si",'+
            '"anioVehiculo":"2020",'+    
            '"idMarcaVehiculo":"240",'+
            '"idModeloVehiculo":"240070",'+
            '"tipoDePagoOp":"",'+
            '"pagoPrimeraCuota":"",'+    
            '"origenProspectoOp":"",'+
            '"codigoProductoElegido":"",'+
            '"numMotor":"",'+
            '"chasis":"",'+
            '"banco":"",'+
            '"tipoTarjeta":"",'+
            '"numeroTarjeta":"",'+
            '"sucursal":"",'+
            '"numeroCuenta":"",'+
            '"numTransaccion":"",'+
            '"tipoEnvio":"PUT"'+
            '}';
        return g;
    }
    
    public static String j2(){
        String g = '{'+
            '"nombreCliente":"[ProsEmailError1]",'+
            '"apellidoPaterno":"[ProsEmailError]",'+
            '"campaniaCotizadorWeb":"Campaña VSV Agosto JGI",'+
            '"duenioVehiculo":"No",'+
            '"pasoCotizacionWeb":"10",'+
            '"prioridad":"1",'+
            '"rutCliente":"15425797",'+
            '"rutDuenioVehiculo":"15425797",'+
            '"digitoVerificadorRutCliente":"7",'+
            '"digitoVerificadorRutDuenioVeh":"7",'+
            '"deducible":"709460001",'+
            '"autoReemplazo":"709460001",'+
            '"resposabilidadCivilOp":"709460001",'+
            '"productoSeleccionado":"709460000",'+
            '"tipoVehiculo":"709460001",'+
            '"emailCliente":"pruebaopel2@prueba.cl",'+
            '"direccionCliente":"",'+
            '"descripcionMarcaVehiculo":"OPELo",'+
            '"descripcionModeloVehiculo":"ANTARAo",'+
            '"esVehiculoNuevoOp":"709460001",'+
            '"fechaEnvioCotizacion":"2021-02-01",'+
            '"idHdiOpWeb":"2021_15425797_OPEL_ANTARA2_2020",'+
            '"oportunidadGestionada":"No",'+    
            '"patenteVehiculo":"",'+
            '"primaCotizacionVehiculo":"",'+    
            '"telefonoCliente":"999999999",'+
            '"vehiculoTienePatenteOp":"Si",'+
            '"anioVehiculo":"2020",'+    
            '"idMarcaVehiculo":"987",'+
            '"idModeloVehiculo":"999999",'+
            '"tipoDePagoOp":"",'+
            '"pagoPrimeraCuota":"",'+    
            '"origenProspectoOp":"",'+
            '"codigoProductoElegido":"",'+
            '"numMotor":"",'+
            '"chasis":"",'+
            '"banco":"",'+
            '"tipoTarjeta":"",'+
            '"numeroTarjeta":"",'+
            '"sucursal":"",'+
            '"numeroCuenta":"",'+
            '"numTransaccion":"",'+
            '"tipoEnvio":"PUT"'+
            '}';
        return g;
    }
    
}