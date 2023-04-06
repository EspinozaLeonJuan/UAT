@isTest(SeeAllData=true)
public class TestJson {
    
    
    static testMethod void testDoPost1(){
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
        req0.requestBody = Blob.valueof(j());
        RestContext.request = req0;
        RestContext.response = res0;
        ApiHDI.create();
        
        RestRequest req1 = new RestRequest(); 
        RestResponse res1 = new RestResponse();
        
        req1.requestURI = '/services/apexrest/create/';  
        req1.httpMethod = 'PUT';
        req1.requestBody = Blob.valueof(u());
        RestContext.request = req1;
        RestContext.response = res1;
        ApiHDI.actualizar();
        
        RestRequest req2 = new RestRequest(); 
        RestResponse res2 = new RestResponse();
        
        req2.requestURI = '/services/apexrest/create/';  
        req2.httpMethod = 'PUT';
        req2.requestBody = Blob.valueof(u2());
        RestContext.request = req2;
        RestContext.response = res2;
        ApiHDI.actualizar();
        
        RestRequest req3 = new RestRequest(); 
        RestResponse res3 = new RestResponse();
        
        req3.requestURI = '/services/apexrest/create/';  
        req3.httpMethod = 'POST';
        req3.requestBody = Blob.valueof(j1());
        RestContext.request = req3;
        RestContext.response = res3;
        ApiHDI.create();
        
        RestRequest req4 = new RestRequest(); 
        RestResponse res4 = new RestResponse();
        
        req4.requestURI = '/services/apexrest/create/';  
        req4.httpMethod = 'PUT';
        req4.requestBody = Blob.valueof(u3());
        RestContext.request = req4;
        RestContext.response = res4;
        ApiHDI.actualizar();
        
        RestRequest req5 = new RestRequest(); 
        RestResponse res5 = new RestResponse();
        
        req5.requestURI = '/services/apexrest/create/';  
        req5.httpMethod = 'PUT';
        req5.requestBody = Blob.valueof(u4());
        RestContext.request = req5;
        RestContext.response = res5;
        ApiHDI.actualizar();
    }
    
    /*static testMethod void testDoPost2(){
        UrlCall.mock = new MockHttpResponseGenerator();
        List<Opportunity> opo = [Select id, HDI4I_Id_Oportunidad_web__c, owner.name, CreatedDate, OwnerId, stagename, HDI4I_Fecha_de_asignacion__c 
                                 from opportunity where OwnerId =: '0053t000007QVfhAAG' and stagename = 'Nuevo' and HDI4I_Id_Oportunidad_web__c != null  and CreatedDate >2021-07-01T17:49:16.000+0000  order by CreatedDate limit 1];
        
        PageReference myVfPage = page.UrlOpportunity;
        Test.setCurrentPage(myVfPage);
        ApexPages.currentPage().getParameters().put('id',opo[0].id);
        ControllerUrlOpportunity con = new ControllerUrlOpportunity();
        con.getId = opo[0].id;
    }*/
    
    /*static testMethod void testDoPost3(){
        List<Quote> q = [select id, OpportunityId, hdi4i_ultima_cotizacion_generada__c, Email from quote where Email != null limit 1];
        q[0].hdi4i_ultima_cotizacion_generada__c = 'Footer_clientes';
        update q;
        
        List<InsurancePolicy> i = [select id, SourceOpportunityId, HDI4I_Ultima_poliza_generada__c, SourceQuoteId from InsurancePolicy limit 1];
        i[0].HDI4I_Ultima_poliza_generada__c = 'Footer_clientes';
        i[0].SourceQuoteId = q[0].id;
        update i;
        
        
    }
    
    static testMethod void testDoPost4(){
       List<Opportunity> o = [select id, HDI4I_Ultima_propuesta_generada__c from Opportunity where id =: '0063t000010KT1xAAG'];
        o[0].HDI4I_Ultima_propuesta_generada__c = 'Footer_clientes';
        update o; 
    }*/
    
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
    
    public static String u2(){
        String g = '{'+
            '"nombreCliente":"[ProsEmailError1]",'+
            '"apellidoPaterno":"[ProsEmailError]",'+
            '"campaniaCotizadorWeb":"Campaña VSV Agosto JGI",'+
            '"duenioVehiculo":"No",'+
            '"pasoCotizacionWeb":"12",'+
            '"prioridad":"3",'+
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
            '"idHdiOpWeb":"2021_15425797_OPEL_ANTARA_2019",'+
            '"oportunidadGestionada":"No",'+    
            '"patenteVehiculo":"",'+
            '"primaCotizacionVehiculo":"",'+    
            '"telefonoCliente":"999999999",'+
            '"vehiculoTienePatenteOp":"Si",'+
            '"anioVehiculo":"2019",'+    
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
    
    public static String u3(){
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
            '"idHdiOpWeb":"2021_15425797_OPEL_ANTARA_2019",'+
            '"oportunidadGestionada":"No",'+    
            '"patenteVehiculo":"",'+
            '"primaCotizacionVehiculo":"",'+    
            '"telefonoCliente":"999999999",'+
            '"vehiculoTienePatenteOp":"Si",'+
            '"anioVehiculo":"2019",'+    
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
    
    public static String u4(){
        String g = '{'+
            '"nombreCliente":"[ProsEmailError1]",'+
            '"apellidoPaterno":"[ProsEmailError]",'+
            '"campaniaCotizadorWeb":"Campaña VSV Agosto JGI",'+
            '"duenioVehiculo":"No",'+
            '"pasoCotizacionWeb":"11",'+
            '"prioridad":"2",'+
            '"rutCliente":"15425798",'+
            '"rutDuenioVehiculo":"15425798",'+
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
            '"idHdiOpWeb":"2021_15425798_OPEL_ANTARA_2016",'+
            '"oportunidadGestionada":"No",'+    
            '"patenteVehiculo":"",'+
            '"primaCotizacionVehiculo":"",'+    
            '"telefonoCliente":"999999999",'+
            '"vehiculoTienePatenteOp":"Si",'+
            '"anioVehiculo":"2016",'+    
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
    
}