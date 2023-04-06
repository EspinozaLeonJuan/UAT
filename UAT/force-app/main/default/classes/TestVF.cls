@isTest
public class TestVF {
	@isTest
    public static void vf(){
        UrlCall.mock = new MockHttpResponseGenerator();
        Test.startTest();
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/create/';  
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueof(j());
        RestContext.request = req;
        RestContext.response = res;
        ApiHDI.create();
        
        RestRequest req1 = new RestRequest(); 
        RestResponse res1 = new RestResponse();
        
        req1.requestURI = '/services/apexrest/create/';  
        req1.httpMethod = 'PUT';
        req1.requestBody = Blob.valueof(u());
        RestContext.request = req1;
        RestContext.response = res1;
        ApiHDI.actualizar();
        
        integer o = [select count() from opportunity];
        system.debug(o);
        
        if(existeOportunidad('2021_15425797_OPEL_ANTARA_2020') == true){
            //Test.startTest();
            system.debug('funciona con api');
            Opportunity opo = new Opportunity();
            opo = ApiHDI.llamarOppo('2021_15425797_OPEL_ANTARA_2020');
            
            system.debug('id de oportunidad: '+opo.id);
            
            PageReference myVfPage = page.UrlOpportunity;
            Test.setCurrentPage(myVfPage);
            ApexPages.currentPage().getParameters().put('id',opo.id);
            ControllerUrlOpportunity con = new ControllerUrlOpportunity();
            con.getId = opo.id;
        }else{
            system.debug('noooo funciona con api');
        }
        Test.stopTest();
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
    public static String u(){
        String g = '{'+
    '"nombreCliente":"[ProsEmailError1]",'+
    '"apellidoPaterno":"[ProsEmailError]",'+
    '"campaniaCotizadorWeb":"Campaña VSV Agosto JGI",'+
    '"duenioVehiculo":"No",'+
    '"pasoCotizacionWeb":"11",'+
    '"prioridad":"2",'+
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
    public static boolean existeOportunidad(string dni){
        
        //system.debug(dni);
        integer cuenta = [Select count() from Opportunity where HDI4I_Id_Oportunidad_web__c  =: dni];
        
        if(cuenta > 0){
            system.debug('DNI existe en una cuenta');
            return true;
        } else {
            system.debug('DNI no existe');
            return false;
        }        
        
    }
}