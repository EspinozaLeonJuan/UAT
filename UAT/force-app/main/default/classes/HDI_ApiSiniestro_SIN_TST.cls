@isTest
private class HDI_ApiSiniestro_SIN_TST {
    
    private class MockHttpResponse implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"status":"success"}');
            res.setStatusCode(200);
            return res;
        }
    }

    @TestSetup
    static void makeData(){

        Case siniestro = new Case();
        siniestro.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName()
        .get('HDI_Siniestro_SIN')
        .getRecordTypeId();
        siniestro.HDI4I_N_Siniestro__c = '113355789';
        siniestro.HDI4I_Nombre_del_asegurado__c = 'Jose';
        siniestro.HDIApellidosDelAsegurado__c = 'Perez Gomez';

        insert siniestro;
    }
    
    @isTest
    static void evento100OK() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        HDI_ApiSiniestros_SIN apiSinRoute = new HDI_ApiSiniestros_SIN();
        List<Case> listSiniestros = new List<Case>();
        Set<String> setNroSiniestros = new Set<String>();
        //HDI_ApiResponseWrapper result = (HDI_ApiResponseWrapper) callTest.doPost();
        req.requestURI = 'https://hdiseguros1--dev2.sandbox.my.salesforce.com/services/apexrest/caso/siniestro';
        req.httpMethod = 'POST';
        req.addHeader('Content-Type', 'application/json');
        //req.requestBody = Blob.valueOf('[{"numeroEvento" : "100","fechaIngresoDenuncio": "2022-02-22T11:11:11","numeroSiniestro": "123123","origenCaso": "Online","fechaOcurrencia": "2022-02-22T11:11:11","nombreAsegurado": "David","apellidosAsegurado": " Quintero Martín","rutAsegurado": "77.777.77","dvAsegurado": "3","culpabilidadAsegurado": "HDICulpable","numeroPoliza": "256789302312","ramo": "Ramo34","producto": "PRO723","certificado": "87624536","nombreConductor": "Nombre Conductor","apellidosConductor": "Apellido Conductor","rutConductor": "RutCond1234","dvConductor": "1","marcaModelo": 890890890890890,"marca": "Marca","modelo": "Modelo","anioVehiculo": "2012","patenteVehiculo": "KLHGFT786","relato": "Relato test","nombreDenunciante": "nombre Denunciante","apellidosDenunciante": "apellido Denunciante","terceros":[]}]');
        req.requestBody= Blob.valueOf('[{"numeroEvento" : "100","fechaIngresoDenuncio": "2022-02-22T11:11:11","numeroSiniestro": "123123","origenCaso": "Online","fechaOcurrencia": "2022-02-22T11:11:11","nombreAsegurado": "David","apellidosAsegurado": " Quintero Martín","rutAsegurado": "77.777.77","dvAsegurado": "3","culpabilidadAsegurado": "HDICulpable","numeroPoliza": "256789302312","ramo": "Ramo34","producto": "PRO723","certificado": "87624536","nombreConductor": "Nombre Conductor","apellidosConductor": "Apellido Conductor","rutConductor": "RutCond1234","dvConductor": "1","marcaModelo": 890890890890890,"marca": "Marca","modelo": "Modelo","anioVehiculo": "2012","patenteVehiculo": "KLHGFT786","relato": "Relato test","nombreDenunciante": "nombre Denunciante","apellidosDenunciante": "apellido Denunciante","terceros":[{"tipo": "Vehiculo","idTercero" : "10","rutConductor": "RutCond78902","dvConductor": "6","nombreConductor": "José Luis","apellidosConductor": "Delgado Pérez","celularConductor": "","emailConductor": "emailconductorterceropd12@hd1.com","direccionConductor": "Calle Santa Pola, 34562 34 Snatiago","rutPropietario": "RutPropiet3678","dvPropietario": "4","nombrePropietario": "Carolina","apellidosPropietario": "Gordo Manises","celularPropietario": "","emailPropietario": "emailpropietarioterceropd12@hd1.com","direccionPropietario": "Calle Santa Engracia, 82 2 izq 872564 Santiago","marcaModelo": 234234234234234123,"descripcionMarcaVehiculo": "Toyot222222a","descripcionModeloVehiculo": "Ayg2sado","aseguradoraVehiculo": "Aseguradora tercero","numeroPolizaVehiculo": "56728372572","patenteVehiculo": "HFYHKI465"}]}]');
        RestContext.request = req;
        Test.startTest();
        RestContext.response = res;      

        try {
        	apiSinRoute.doPost();
        } catch (HDI_RestRouteError.RestException e) {
            System.assertEquals(
                500,
                e.statusCode
            );
        }
        res = RestContext.response;

        System.debug('RESPUESTA:' + RestContext.response.statusCode);

        Test.stopTest();
       // System.assertEquals(0, result.listError.size(), 'Expected no errors');
       setNroSiniestros.add('123123');
       listSiniestros = new HDI_CaseSelector().selectCaseWithTerceros(setNroSiniestros);
       
       System.debug('RESPUESTA listSiniestros:' + listSiniestros);
       System.assertEquals(200, RestContext.response.statusCode);

    }

    @isTest
    static void evento110OK() {

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        HDI_ApiSiniestros_SIN apiSinRoute = new HDI_ApiSiniestros_SIN();

        req.requestURI = 'https://hdiseguros1--dev2.sandbox.lightning.force.com/services/apexrest/caso/siniestro';
        req.httpMethod = 'PUT';
        req.addHeader('Content-Type', 'application/json');
        req.requestBody = Blob.valueOf('[{"numeroEvento" : "110", "numeroSiniestro" : "113355789", "fechaAsignacionLiquidador" : "2022-04-10T14:00:00",'+
                                        '"idLiquidador" : "idliqui1", "idEjecutivo" : "idejecut1", "idAsesor" : "idasesor1"}]');

        RestContext.request = req;

        Test.startTest();
        RestContext.response = res;
        

        try {
        	apiSinRoute.doPut();
        } catch (HDI_RestRouteError.RestException e) {
            System.assertEquals(
                500,
                e.statusCode
            );
        }

        res = RestContext.response;

        System.debug('RESPUESTA:' + RestContext.response.statusCode);
        Test.stopTest(); 

        List<Case> siniestros = [SELECT HDI4I_N_Siniestro__c, HDI4I_ID_del_liquidador__c, HDITipoDeLiquidador__c, HDIFechaHoraDeAsignacion__c,
        HDIEmail_Liquidador__c, HDITelefonoLiquidador__c, HDI4I_Rut_del_taller__c  FROM Case WHERE HDI4I_N_Siniestro__c = '113355789'];

        Datetime dt = Datetime.newInstance(2022, 04, 10, 14, 00, 00);

        System.debug('fecha asignacion: ' + siniestros[0].HDIFechaHoraDeAsignacion__c);

        System.assertEquals(dt, siniestros[0].HDIFechaHoraDeAsignacion__c);

        System.debug('usuarios: ' + [SELECT COUNT() FROM User]);
    }

    @isTest
    static void evento111OK() {

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        HDI_ApiSiniestros_SIN apiSinRoute = new HDI_ApiSiniestros_SIN();

        req.requestURI = 'https://hdiseguros1--dev2.sandbox.lightning.force.com/services/apexrest/caso/siniestro';
        req.httpMethod = 'PUT';
        req.addHeader('Content-Type', 'application/json');
        req.requestBody = Blob.valueOf('[{"numeroEvento" : "111", "numeroSiniestro" : "113355789", "fechaReasignacionLiquidador" : "2022-04-10T14:00:00",'+
                                        '"idLiquidador" : "idliqui1", "idEjecutivo" : "idejecut1", "idAsesor" : "idasesor1", "rutTaller" : "ruttall678.-","dvTaller" : "8","nombreTaller" : "Taller 1","sucursalTaller" : "Sucursal 1","direccionTaller" : "Avenida del taller 1, 34 678963 Santiago","telefonoTaller" : "678844336"}]');

        RestContext.request = req;

        Test.startTest();
        RestContext.response = res;
        

        try {
        	apiSinRoute.doPut();
        } catch (HDI_RestRouteError.RestException e) {
            System.assertEquals(
                500,
                e.statusCode
            );
        }

        res = RestContext.response;

        System.debug('RESPUESTA:' + RestContext.response.statusCode);
        Test.stopTest(); 

        List<Case> siniestros = [SELECT HDI4I_N_Siniestro__c, HDI4I_Fecha_reasignacion_liquidador__c  FROM Case WHERE HDI4I_N_Siniestro__c = '113355789'];

        Datetime dt = Datetime.newInstance(2022, 04, 10, 14, 00, 00);

        System.debug('fecha asignacion: ' + siniestros[0].HDI4I_Fecha_reasignacion_liquidador__c);

        //System.assertEquals(dt, siniestros[0].HDI4I_Fecha_reasignacion_liquidador__c);

        System.debug('usuarios: ' + [SELECT COUNT() FROM User]);
    }

    @isTest
    static void evento112OK() {

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        HDI_ApiSiniestros_SIN apiSinRoute = new HDI_ApiSiniestros_SIN();

        req.requestURI = 'https://hdiseguros1--dev2.sandbox.lightning.force.com/services/apexrest/caso/siniestro';
        req.httpMethod = 'PUT';
        req.addHeader('Content-Type', 'application/json');
        req.requestBody = Blob.valueOf('[{"numeroEvento" : "112", "numeroSiniestro" : "113355789", "fechaActualizacionEmailEjecutivo" : "2022-04-10T14:00:00",'+
                                        '"idLiquidador" : "idliqui1", "idEjecutivo" : "idejecut1", "idAsesor" : "idasesor1"},'+
                                        '{"numeroEvento" : "112", "numeroSiniestro" : "113355700", "fechaActualizacionEmailEjecutivo" : "2022-04-10T14:00:00",'+
                                        '"idLiquidador" : "idliqui1", "idEjecutivo" : "idejecut1", "idAsesor" : "idasesor1"},'+
                                        '{"numeroEvento" : "112", "numeroSiniestro" : "", "fechaActualizacionEmailEjecutivo" : "2022-04-10T14:00:00",'+
                                        '"idLiquidador" : "idliqui1", "idEjecutivo" : "idejecut1", "idAsesor" : "idasesor1"}]');

        RestContext.request = req;

        Test.startTest();
        RestContext.response = res;
        

        try {
        	apiSinRoute.doPut();
        } catch (HDI_RestRouteError.RestException e) {
            System.assertEquals(
                500,
                e.statusCode
            );
        }

        res = RestContext.response;

        System.debug('RESPUESTA:' + RestContext.response.statusCode);
        Test.stopTest(); 

        List<Case> siniestros = [SELECT HDI4I_N_Siniestro__c, HDIFecha_actualizacion_email_Ejecutivo__c  FROM Case WHERE HDI4I_N_Siniestro__c = '113355789'];

        Datetime dt = Datetime.newInstance(2022, 04, 10, 14, 00, 00);

        System.debug('fecha asignacion: ' + siniestros[0].HDIFecha_actualizacion_email_Ejecutivo__c);

        System.assertEquals(dt, siniestros[0].HDIFecha_actualizacion_email_Ejecutivo__c);

        System.debug('usuarios: ' + [SELECT COUNT() FROM User]);
    }

    @isTest
    static void eventoError() {

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        HDI_ApiSiniestros_SIN apiSinRoute = new HDI_ApiSiniestros_SIN();

        req.requestURI = 'https://hdiseguros1--dev2.sandbox.lightning.force.com/services/apexrest/caso/siniestro';
        req.httpMethod = 'PUT';
        req.addHeader('Content-Type', 'application/json');
        req.requestBody = Blob.valueOf('[{"numeroEvento" : "112", "numeroSiniestro" : "113355789", "fechaActualizacionEmailEjecutivo" : "2022-04-10T14:00:00",'+
                                        '"idLiquidador" : "idliqui1", "idEjecutivo" : "idejecut1", "idAsesor" : "idasesor1"},'+
                                        '{"numeroEvento" : "112", "numeroSiniestro" : "113355700", "fechaActualizacionEmailEjecutivo" : "2022-04-10T14:00:00",'+
                                        '"idLiquidador" : "idliqui1", "idEjecutivo" : "idejecut1", "idAsesor" : "idasesor1"},'+
                                        '{"numeroEvento" : "112", "numeroSiniestro" : "", "fechaActualizacionEmailEjecutivo" : "2022-04-10T14:00:00",'+
                                        '"idLiquidador" : "idliqui1", "idEjecutivo" : "idejecut1", "idAsesor" : "idasesor1"');

        RestContext.request = req;

        Test.startTest();
        RestContext.response = res;
        

        try {
        	apiSinRoute.doPut();
        } catch (HDI_RestRouteError.RestException e) {
            new HDI_RestRouteError.RestException(
                'Error en la conversion del JSON: ' + e.getMessage(),
                'ERROR_EXECUTION_EXEPTION',
                500
            );
        }

        res = RestContext.response;
        Test.stopTest(); 
    }

  
}