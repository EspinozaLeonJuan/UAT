@isTest
public class ApiHDITest {
    private static List<Schema.SObjectType> MY_SOBJECTS =
    new Schema.SObjectType[] {Opportunity.SObjectType};

    @TestSetup
    static void makeData(){
        Account acc = new Account(LastName = 'Test Company', Rut_sin_puntos_y_con_gui_n__pc = '15479853', PersonMobilePhone = '9908124632', 
        HDI4I_RUT_del_cliente__c = '15479853', CurrencyIsoCode = 'CLF', PersonEmail = 'test@gmail.com');
        insert acc;

        Lead le = new Lead();
        le.LastName = 'test';
        le.LeadSource = 'VSV2';
        le.Status = 'Calificado';
        le.Rut_sin_puntos_y_con_gui_n__c = '13643049-1';
        le.HDI4I_Id_Marca_vehiculo__c = '538';
        le.HDI4I_Id_Modelo_vehiculo__c = '538012';
        le.HDI4I_RUT_del_cliente__c = '13643049-1';
        le.HDI4I_Auto_reemplazo__c = '30 Días';
        le.HDI4I_Ano_del_vehiculo__c = '2017';
        le.HDI4I_Campana_cotizador_web__c = 'Campaña VSV Agosto JGI';
        le.HDI4I_Codigo_de_producto_elegido__c = '662';
        le.HDI4I_Deducible__c = '3 UF';
        le.HDI4I_Digito_verificador_rut_cliente__c = 'K';
        le.HDI4I_Digito_verif_rut_dueno_vehiculo__c = 'K';
        le.HDI4I_Fecha_envio_cotizacion__c = system.now();
        le.HDI4I_Hora_cronometro__c = '20:18:08:939';
        le.HDI4I_Id_Oportunidad_web__c = '2022_15176715_CHERY_FULWIN_2017';
        le.HDI4I_IdTarifa__c = '';
        insert le;

        
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

    private static String getJsonSuccess1(){
        String result = '';
        result += '{"idCuenta": "0016s00000SBc1fAAD","nombreCliente": "Test v1","apellidoPaterno": "Last name","campaniaCotizadorWeb": "Test campaniaCotizadorWeb","duenioVehiculo": "No","deducible": "709460000",';
        result += '"autoReemplazo": "709460000","productoSeleccionado": "709460000","tipoVehiculo": "709460000","emailCliente": "","direccionCliente": "","descripcionMarcaVehiculo": "","descripcionModeloVehiculo": "",';
        result += '"digitoVerificadorRutCliente": "","digitoVerificadorRutDuenioVeh": "","esVehiculoNuevoOp": "709460000","fechaEnvioCotizacion": "2021-01-30","idHdiOpWeb": "2022_15176715_CHERY_FULWIN_2018",';
        result += '"oportunidadGestionada": "","pasoCotizacionWeb": "1000","patenteVehiculo": "","primaCotizacionVehiculo": "","rutCliente": "15479853","rutDuenioVehiculo": "15479853","telefonoCliente": "",';
        result += '"vehiculoTienePatenteOp": "","anioVehiculo": "","resposabilidadCivilOp": "709460000","idMarcaVehiculo": "","idModeloVehiculo": "","tipoDePagoOp": "709460000","pagoPrimeraCuota": "709460000",';
        result += '"prioridad": "","origenProspectoOp": "752230001","UTMGoogle": "","IdTarifa": "","codigoProductoElegido": "","chasis": "","numMotor": "","banco": "","tipoTarjeta": "","numeroTarjeta": "","sucursal": "",';
        result += '"numeroCuenta": "","numTransaccion": "","diaCargo": "","tipoEnvio": ""}';
        return result;
    }

    private static String getJsonSuccess2(){
        String result = '';
        result += '{"idCuenta": "0016s00000SBc1fAAD","nombreCliente": "Test v1","apellidoPaterno": "Last name","campaniaCotizadorWeb": "Test campaniaCotizadorWeb","duenioVehiculo": "No","deducible": "709460000",';
        result += '"autoReemplazo": "709460000","productoSeleccionado": "709460000","tipoVehiculo": "709460000","emailCliente": "","direccionCliente": "","descripcionMarcaVehiculo": "","descripcionModeloVehiculo": "",';
        result += '"digitoVerificadorRutCliente": "","digitoVerificadorRutDuenioVeh": "","esVehiculoNuevoOp": "709460000","fechaEnvioCotizacion": "2021-01-30","idHdiOpWeb": "2022_15176715_CHERY_FULWIN_2017",';
        result += '"oportunidadGestionada": "","pasoCotizacionWeb": "1000","patenteVehiculo": "","primaCotizacionVehiculo": "","rutCliente": "15479853","rutDuenioVehiculo": "15479853","telefonoCliente": "",';
        result += '"vehiculoTienePatenteOp": "","anioVehiculo": "","resposabilidadCivilOp": "709460000","idMarcaVehiculo": "","idModeloVehiculo": "","tipoDePagoOp": "709460000","pagoPrimeraCuota": "709460000",';
        result += '"prioridad": "","origenProspectoOp": "752230001","UTMGoogle": "","IdTarifa": "","codigoProductoElegido": "","chasis": "","numMotor": "","banco": "","tipoTarjeta": "","numeroTarjeta": "","sucursal": "",';
        result += '"numeroCuenta": "","numTransaccion": "","diaCargo": "","tipoEnvio": ""}';
        return result;
    }

    private static String getJsonSuccess3(){
        String result = '';
        result += '{"idCuenta": "0016s00000SBc1fAAD","nombreCliente": "Test v1","apellidoPaterno": "Last name","campaniaCotizadorWeb": "Test campaniaCotizadorWeb","duenioVehiculo": "No","deducible": "709460000",';
        result += '"autoReemplazo": "709460000","productoSeleccionado": "709460000","tipoVehiculo": "709460000","emailCliente": "","direccionCliente": "","descripcionMarcaVehiculo": "","descripcionModeloVehiculo": "",';
        result += '"digitoVerificadorRutCliente": "","digitoVerificadorRutDuenioVeh": "","esVehiculoNuevoOp": "709460000","fechaEnvioCotizacion": "2021-01-30","idHdiOpWeb": "2022_15176715_CHERY_FULWIN_2018",';
        result += '"oportunidadGestionada": "","pasoCotizacionWeb": "10","patenteVehiculo": "","primaCotizacionVehiculo": "","rutCliente": "12345678","rutDuenioVehiculo": "15479853","telefonoCliente": "",';
        result += '"vehiculoTienePatenteOp": "","anioVehiculo": "","resposabilidadCivilOp": "709460000","idMarcaVehiculo": "","idModeloVehiculo": "","tipoDePagoOp": "709460000","pagoPrimeraCuota": "709460000",';
        result += '"prioridad": "","origenProspectoOp": "752230001","UTMGoogle": "","IdTarifa": "","codigoProductoElegido": "","chasis": "","numMotor": "","banco": "","tipoTarjeta": "","numeroTarjeta": "","sucursal": "",';
        result += '"numeroCuenta": "","numTransaccion": "","diaCargo": "","tipoEnvio": ""}';
        return result;
    }
    
    private static String getJsonSuccess4(){
        String result = '';
        result += '{"idCuenta": "0016s00000SBc1fAAD","nombreCliente": "Test v1","apellidoPaterno": "Last name","campaniaCotizadorWeb": "Test campaniaCotizadorWeb","duenioVehiculo": "No","deducible": "709460000",';
        result += '"autoReemplazo": "709460000","productoSeleccionado": "709460000","tipoVehiculo": "709460000","emailCliente": "","direccionCliente": "","descripcionMarcaVehiculo": "","descripcionModeloVehiculo": "",';
        result += '"digitoVerificadorRutCliente": "","digitoVerificadorRutDuenioVeh": "","esVehiculoNuevoOp": "709460000","fechaEnvioCotizacion": "2021-01-30","idHdiOpWeb": "2022_15176715_CHERY_FULWIN_2018",';
        result += '"oportunidadGestionada": "","pasoCotizacionWeb": "12","patenteVehiculo": "","primaCotizacionVehiculo": "","rutCliente": "12345678","rutDuenioVehiculo": "15479853","telefonoCliente": "",';
        result += '"vehiculoTienePatenteOp": "","anioVehiculo": "","resposabilidadCivilOp": "709460000","idMarcaVehiculo": "","idModeloVehiculo": "","tipoDePagoOp": "709460000","pagoPrimeraCuota": "709460000",';
        result += '"prioridad": "","origenProspectoOp": "752230001","UTMGoogle": "","IdTarifa": "","codigoProductoElegido": "","chasis": "","numMotor": "","banco": "","tipoTarjeta": "","numeroTarjeta": "","sucursal": "",';
        result += '"numeroCuenta": "","numTransaccion": "","diaCargo": "","tipoEnvio": ""}';
        return result;
    }

    private static String getJsonSuccess5(){
        String result = '';
        result += '{"idCuenta": "0016s00000SBc1fAAD","nombreCliente": "Test v1","apellidoPaterno": "Last name","campaniaCotizadorWeb": "Test campaniaCotizadorWeb","duenioVehiculo": "No","deducible": "709460000",';
        result += '"autoReemplazo": "709460000","productoSeleccionado": "709460000","tipoVehiculo": "709460000","emailCliente": "","direccionCliente": "","descripcionMarcaVehiculo": "","descripcionModeloVehiculo": "",';
        result += '"digitoVerificadorRutCliente": "","digitoVerificadorRutDuenioVeh": "","esVehiculoNuevoOp": "709460000","fechaEnvioCotizacion": "2021-01-30","idHdiOpWeb": "2022_15176715_CHERY_FULWIN_2022",';
        result += '"oportunidadGestionada": "","pasoCotizacionWeb": "12","patenteVehiculo": "","primaCotizacionVehiculo": "","rutCliente": "12345678","rutDuenioVehiculo": "15479853","telefonoCliente": "",';
        result += '"vehiculoTienePatenteOp": "","anioVehiculo": "","resposabilidadCivilOp": "709460000","idMarcaVehiculo": "","idModeloVehiculo": "","tipoDePagoOp": "709460000","pagoPrimeraCuota": "709460000",';
        result += '"prioridad": "","origenProspectoOp": "752230001","UTMGoogle": "","IdTarifa": "","codigoProductoElegido": "","chasis": "","numMotor": "","banco": "","tipoTarjeta": "","numeroTarjeta": "","sucursal": "",';
        result += '"numeroCuenta": "","numTransaccion": "","diaCargo": "","tipoEnvio": ""}';
        return result;
    }

    private static String getJsonSuccess6(){
        String result = '';
        result += '{"idCuenta": "0016s00000SBc1fAAD","nombreCliente": "Test v1","apellidoPaterno": "Last name","campaniaCotizadorWeb": "Test campaniaCotizadorWeb","duenioVehiculo": "No","deducible": "709460000",';
        result += '"autoReemplazo": "709460000","productoSeleccionado": "709460000","tipoVehiculo": "709460000","emailCliente": "","direccionCliente": "","descripcionMarcaVehiculo": "","descripcionModeloVehiculo": "",';
        result += '"digitoVerificadorRutCliente": "","digitoVerificadorRutDuenioVeh": "","esVehiculoNuevoOp": "709460000","fechaEnvioCotizacion": "2021-01-30","idHdiOpWeb": "2022_15176715_CHERY_FULWIN_2022",';
        result += '"oportunidadGestionada": "","pasoCotizacionWeb": "12","patenteVehiculo": "","primaCotizacionVehiculo": "","rutCliente": "12345678","rutDuenioVehiculo": "15479853","telefonoCliente": "",';
        result += '"vehiculoTienePatenteOp": "","anioVehiculo": "","resposabilidadCivilOp": "709460000","idMarcaVehiculo": "","idModeloVehiculo": "","tipoDePagoOp": "709460000","pagoPrimeraCuota": "709460000",';
        result += '"prioridad": "","origenProspectoOp": "752230001","UTMGoogle": "","IdTarifa": "","codigoProductoElegido": "","chasis": "","numMotor": "","banco": "","tipoTarjeta": "","numeroTarjeta": "","sucursal": "",';
        result += '"numeroCuenta": "","numTransaccion": "","diaCargo": "","tipoEnvio": ""}';
        return result;
    }

    @isTest
    public static void updateSuccess(){
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/create/';  
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueof(getJsonSuccess3());
        RestContext.request = req;
        RestContext.response = res;
       
        
        //Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        UrlCall.mock = new MockHttpResponseGenerator();
        CreateAPI api = new CreateAPI();
        api = api();           
        
        ApiHDI.create();
        req.requestURI = '/services/apexrest/create/';  
        req.httpMethod = 'PUT';
        req.requestBody = Blob.valueof(getJsonSuccess4());
        RestContext.request = req;
        RestContext.response = res;

        Test.startTest();
        ApiHDI.actualizar();
        Test.stopTest();
    }

    @isTest
    public static void updateFoundAccount(){
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/create/';  
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueof(getJsonSuccess3());
        RestContext.request = req;
        RestContext.response = res;
       
        
        //Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        UrlCall.mock = new MockHttpResponseGenerator();
        CreateAPI api = new CreateAPI();
        api = api();           
        
        ApiHDI.create();
        req.requestURI = '/services/apexrest/create/';  
        req.httpMethod = 'PUT';
        req.requestBody = Blob.valueof(getJsonSuccess6());
        RestContext.request = req;
        RestContext.response = res;

        Test.startTest();
        ApiHDI.actualizar();
        Test.stopTest();
    }
    
    @isTest
    public static void CreateError(){
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/create/';  
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueof(getJsonError());
        RestContext.request = req;
        RestContext.response = res;
       
        
        //Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        UrlCall.mock = new MockHttpResponseGenerator();
        CreateAPI api = new CreateAPI();
        api = api();           
        
        Test.startTest();
        ApiHDI.create();
        
        Test.stopTest();
    }
    
    @isTest
    public static void CreateSuccess1(){
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/create/';  
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueof(getJsonSuccess1());
        RestContext.request = req;
        RestContext.response = res;
       
        
        //Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        UrlCall.mock = new MockHttpResponseGenerator();
        CreateAPI api = new CreateAPI();
        api = api();           
        
        Test.startTest();
        ApiHDI.create();
        
        Test.stopTest();
    }
    
    @isTest
    public static void CreateSuccess2(){
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/create/';  
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueof(getJsonSuccess2());
        RestContext.request = req;
        RestContext.response = res;
       
        
        //Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        UrlCall.mock = new MockHttpResponseGenerator();
        CreateAPI api = new CreateAPI();
        api = api();           
        
        Test.startTest();
        ApiHDI.create();
        
        Test.stopTest();
    }
    
    @isTest
    public static void CreateSuccess3(){
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/create/';  
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueof(getJsonSuccess3());
        RestContext.request = req;
        RestContext.response = res;
       
        
        //Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        UrlCall.mock = new MockHttpResponseGenerator();
        CreateAPI api = new CreateAPI();
        api = api();           
        
        Test.startTest();
        ApiHDI.create();
        
        Test.stopTest();
    }

    @isTest
    public static void CreateSuccess4(){
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/create/';  
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueof(getJsonSuccess5());
        RestContext.request = req;
        RestContext.response = res;
       
        
        //Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        UrlCall.mock = new MockHttpResponseGenerator();
        CreateAPI api = new CreateAPI();
        api = api();           
        
        Test.startTest();
        ApiHDI.create();
        List<lead> propsList = [SELECT Id FROM Lead WHERE HDI4I_Id_Oportunidad_web__c = '2022_15176715_CHERY_FULWIN_2022'];
        delete propsList;
        ApiHDI.create();
        Test.stopTest();
    }
    
    @isTest
    public static void Create(){
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/create/';  
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueof(TestJson.j());
        RestContext.request = req;
        RestContext.response = res;
       
        
        //Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        UrlCall.mock = new MockHttpResponseGenerator();
        CreateAPI api = new CreateAPI();
        api = api();           
        
        Test.startTest();
        ApiHDI.create();
        
        api.deducible = '709460003';
        api.autoReemplazo = '709460001';
        api.resposabilidadCivilOp = '709460000';
        api.pasoCotizacionWeb = '11';
        api.prioridad = '2';
        
        ApiHDI.actualizar();
        //Test.stopTest();
        
        if(existeOportunidad(api.idHdiOpWeb) == true){
            //Test.startTest();
            system.debug('funciona con api');
            Opportunity opo = new Opportunity();
            //opo = ApiHDI.detalleOportunidad();
            
            system.debug('id de oportunidad: '+opo.id);
            
            PageReference myVfPage = page.UrlOpportunity;
            Test.setCurrentPage(myVfPage);
            ApexPages.currentPage().getParameters().put('id',opo.id);
            ControllerUrlOpportunity con = new ControllerUrlOpportunity();
            con.getId = opo.id;
        }
        //Creación de prospectos 
        CreateAPI api2 = new CreateAPI();
        api2 = api();
        api2.nombreCliente = 'prueba2';
        api2.idHdiOpWeb = '2020_16551364_OPEL_ANTARA_2020';
        api2.tipoVehiculo = '709460000';
        api2.tipoDePagoOp = '709460001';
        api2.origenProspectoOp = '752230001';
        api2.esVehiculoNuevoOp = '709460001';
        api2.pagoPrimeraCuota = '709460001';
        ApiHDI.create();
        
        CreateAPI api3 = new CreateAPI();
        api3 = api();
        api3.nombreCliente = 'prueba3';
        api3.idHdiOpWeb = '2020_16551364_OPEL_ANTARA_2021';
        api3.tipoVehiculo = '709460002';
        api3.tipoDePagoOp = '709460002';
        api3.origenProspectoOp = '752230001';
        ApiHDI.create();
        
        CreateAPI api4 = new CreateAPI();
        api4 = api();
        api4.nombreCliente = 'prueba4';
        api4.idHdiOpWeb = '2020_16551364_OPEL_ANTARA_2022';
        api4.tipoVehiculo = '709460003';
        api4.tipoDePagoOp = '709460002';
        api4.origenProspectoOp = '752230001';
        ApiHDI.create();
        
        CreateAPI api5 = new CreateAPI();
        api5 = api();
        api5.nombreCliente = 'prueba5';
        api5.idHdiOpWeb = '2020_16551364_OPEL_ANTARA_2023';
        api5.tipoVehiculo = '709460004';
        api5.tipoDePagoOp = '709460002';
        api5.origenProspectoOp = '752230001';
        ApiHDI.create();
        
        CreateAPI api6 = new CreateAPI();
        api6 = api();
        api6.nombreCliente = 'prueba6';
        api6.idHdiOpWeb = '2020_16551364_OPEL_ANTARA_2024';
        api6.tipoVehiculo = '709460005';
        api6.tipoDePagoOp = '709460002';
        api6.origenProspectoOp = '752230001';
        ApiHDI.create();
        
        CreateAPI api7 = new CreateAPI();
        api7 = api();
        api7.nombreCliente = 'prueba7';
        api7.rutCliente = '18473829';
        api7.idHdiOpWeb = '2020_18473829_OPEL_ANTARA_2025';
        api7.tipoVehiculo = '709460006';
        api7.tipoDePagoOp = '709460002';
        api7.origenProspectoOp = '752230001';
        ApiHDI.create();
        
        // Actualización de prospectos/oportunidades
        api7.deducible = '709460002';
        api7.pagoPrimeraCuota = '709460001';
        api7.autoReemplazo = '709460001';
        api7.resposabilidadCivilOp = '709460000';
        api7.tipoVehiculo = '709460005';
        api7.tipoDePagoOp = '709460002';
        //api7.pasoCotizacionWeb = '11';
        api7.prioridad = '2';
        ApiHDI.actualizar();
        api7.tipoDePagoOp = '709460001';
        api7.resposabilidadCivilOp = '709460001';
        api7.deducible = '709460001';
        api7.esVehiculoNuevoOp = ' ';
        api7.autoReemplazo = '709460000';
        api7.tipoVehiculo = '709460004';
        ApiHDI.actualizar();
        api7.resposabilidadCivilOp = '709460002';
        api7.deducible = '709460000';
        api7.esVehiculoNuevoOp = '709460001';
        api7.autoReemplazo = '709460002';
        api7.tipoVehiculo = '709460003';
        ApiHDI.actualizar();
        /*api7.autoReemplazo = '709460003';
        api7.tipoVehiculo = '709460002';
        ApiHDI.actualizar();
        api7.tipoVehiculo = '709460001';
        ApiHDI.actualizar();
        api7.tipoVehiculo = '709460000';
        ApiHDI.actualizar();
        api7.tipoVehiculo = '709460006';*/
        //ApiHDI.actualizar(api7);
        
        //api.patenteVehiculo = 'gcwc65';
        //api.pasoCotizacionWeb = '13';
        //ApiHDI.actualizar(api);
        
        /*api4.deducible = '709460003';
api4.autoReemplazo = '709460001';
api4.resposabilidadCivilOp = '709460000';
api4.pasoCotizacionWeb = '11';
api4.prioridad = '2';
ApiHDI.actualizar(api4);*/
        Test.stopTest();
        //Test.setMock(UrlCall.class, new RestMock());
        
    }
    @isTest
    public static void Create2(){
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/create/';  
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueof(TestJson.j());
        RestContext.request = req;
        RestContext.response = res;
        
        List<Lead> l = new List<Lead>();
        List<Opportunity> o = new List<Opportunity>();
        List<Account> a = new List<Account>();
        
        CreateAPI api = new CreateAPI();
        api = api();
        
        Test.startTest();
        api.idHdiOpWeb = '2020_16551364_OPEL_ANTARA_2012';
        api.rutCliente = '16551399';
        api.telefonoCliente = '999999998';
        ApiHDI.create();
        
        api.deducible = '709460003';
        api.autoReemplazo = '709460001';
        api.resposabilidadCivilOp = '709460000';
        api.pasoCotizacionWeb = '11';
        api.prioridad = '2';
        
        ApiHDI.actualizar();
        
        CreateAPI api2 = new CreateAPI();
        api2 = api();
        
        api2.idHdiOpWeb = '2020_16551364_OPEL_ANTARA_2011';
        api2.rutCliente = '16551399';
        ApiHDI.create();
        
        api2.deducible = '709460003';
        api2.autoReemplazo = '709460001';
        api2.resposabilidadCivilOp = '709460000';
        //api2.pasoCotizacionWeb = '11';
        api2.prioridad = '2';
        ApiHDI.actualizar();
        
        Test.stopTest();
    }
    @isTest
    public static void error(){
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/create/';  
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueof(TestJson.j());
        RestContext.request = req;
        RestContext.response = res;
        
        List<Lead> l = new List<Lead>();
        List<Opportunity> o = new List<Opportunity>();
        List<Account> a = new List<Account>();
        CreateAPI api = new CreateAPI();
        api = api();
        Test.startTest();
        api.idHdiOpWeb = '2020_16400835_OPEL_ANTARA_2019';
        api.prioridad = '3';
        api.pasoCotizacionWeb = '12';
        api.emailCliente = 'opel356@prueba.cl';
        
        RestRequest req1 = new RestRequest(); 
        RestResponse res1 = new RestResponse();
        
        req1.requestURI = '/services/apexrest/create/';  
        req1.httpMethod = 'PUT';
        req1.requestBody = Blob.valueof(TestJson.u());
        RestContext.request = req1;
        RestContext.response = res1;
        
        ApiHDI.actualizar();
        Test.stopTest();
    }
    
    public static CreateAPI api(){
        CreateAPI api = new CreateAPI();
        api.nombreCliente = 'Prueba';
        api.apellidoPaterno = 'Prueba';
        api.campaniaCotizadorWeb = 'Campaña VSV Agosto JGI';
        api.duenioVehiculo = 'No';
        api.deducible = '';
        api.autoReemplazo = '';
        api.productoSeleccionado = '709460000';
        api.tipoVehiculo = '709460001';
        api.emailCliente = 'opel3@prueba.cl';
        api.direccionCliente = '';
        api.descripcionMarcaVehiculo = 'OPEL';
        api.descripcionModeloVehiculo = 'ANTARA';
        api.digitoVerificadorRutCliente = '9';
        api.digitoVerificadorRutDuenioVeh = '9';
        api.esVehiculoNuevoOp = '709460000';
        api.fechaEnvioCotizacion = system.now().date();
        api.idHdiOpWeb = '2020_16551364_OPEL_ANTARA_2019';
        api.oportunidadGestionada = 'No';
        api.pasoCotizacionWeb = '10';
        api.patenteVehiculo = '';
        api.primaCotizacionVehiculo = '';
        api.rutCliente = '16551365';
        api.rutDuenioVehiculo = '16551365';
        api.telefonoCliente = '999999999';
        api.vehiculoTienePatenteOp = 'Si';
        api.anioVehiculo = '2019';
        api.resposabilidadCivilOp = '';
        api.idMarcaVehiculo = '240';
        api.idModeloVehiculo = '240070';
        api.tipoDePagoOp = '709460000';
        api.pagoPrimeraCuota = '709460000';
        api.prioridad = '1';
        api.origenProspectoOp = '';
        api.codigoProductoElegido = '';
        api.numMotor = '';
        api.chasis = '';
        api.banco = '';
        api.tipoTarjeta = '';
        api.numeroTarjeta = '';
        api.sucursal = '';
        api.numeroCuenta = '';
        api.numTransaccion = '';
        
        return api;
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