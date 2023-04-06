@isTest
public  class HDI_Siniestros_Test {

    @TestSetup
    static void makeData(){
        Account cuenta = new Account();
        cuenta.Name = 'test hdi';
        insert cuenta;

        Entitlement asignacion = new Entitlement();
        asignacion.AccountId = cuenta.id;
        asignacion.PorDefectoSiniestros__c = true;
        asignacion.Name = 'test asignacion';
        asignacion.StartDate = date.today();
        SlaProcess sProcess = new HDI_SlaProcessSelector().selectByName(Label.SLAs_Siniestros);
        asignacion.SlaProcessId = sProcess.id;
        insert asignacion;
    }

    @IsTest
    static void testAPI(){

        HDI_ApiSiniestroJSON jsonToTest = new HDI_ApiSiniestroJSON();
        jsonToTest.tipoEvento = '100';
        jsonToTest.estadoDenuncio = 'Denunciado';
        jsonToTest.numeroSiniestro = '1212112';
        jsonToTest.polizaConcatenado = '';
        jsonToTest.ramo = '69';
        jsonToTest.producto = '1703';
        jsonToTest.poliza = '269403';
        jsonToTest.certificado = '0';
        jsonToTest.fechaOcurrencia = '04-09-2021 00:00:00';
        jsonToTest.fechaDenuncia = '06-09-2021 00:00:00';
        jsonToTest.canalDenuncia = 'Internet';
        jsonToTest.rutAsegurado = '77139763-8';
        jsonToTest.nombreAsegurado = 'ARRIENDO DE MAQUINAR';
        jsonToTest.celularAsegurado = '65656792';
        jsonToTest.mailContacto = 'miguel@servigraff.cl';
        jsonToTest.rutConductor = '21140509-1';
        jsonToTest.nombreConductor = 'MIGUEL ANGEL GUTIERREZ ALIAGA';
        jsonToTest.marca = 'PEUGEOT';
        jsonToTest.modelo = 'RIFTER';
        jsonToTest.anio = '2021';
        jsonToTest.patente = 'PXYH45';
        jsonToTest.idLiquidador = '10009684';
        jsonToTest.liquidador = 'Charle Wilder Cuello Arguello';
        jsonToTest.rutTaller = '0-0';
        jsonToTest.nombreTaller = 'Taller';
        jsonToTest.relato = 'DEEJE EL VEHICULO ESTACIONADO Y ME DIRIGI A MI DPTO PARA RETIRAR COSAS PERSONALES CUANDO BAJE EL VEHICULO ESTABA CHOCADO Y NO HABIA NADIE EN EL SECTOR YA QUE ERA MUY TEMPRANO . SOLO ALCANZE A DIVISAR RESTO DE PINTURA ROJA QUE ASUMO FUE DEL VEHICULO QUE ME CHOCO';
        jsonToTest.idInvolucrado = '1';
        jsonToTest.nombreInvolucrado = 'FELIPE ANDRES SANZANA ALDUNATE';
        jsonToTest.rutInvolucrado = '17614902-7';
        jsonToTest.fechaRecepcionVehiculo = '09-09-2021 00:00:00';
        jsonToTest.idCobertura = '59';
        jsonToTest.nombreCobertura = 'DAÑOS MATERIALES A CONSECUENCIA DE ACTOS MALICIOSOS';
        jsonToTest.fechaReasignacionTaller = '20-10-2021 00:00:00';
        jsonToTest.fechaReasignacionLiquidador = '20-10-2021 00:00:00';
        jsonToTest.fechaRechazo = '20-10-2021 00:00:00';
        jsonToTest.provision = '18';
        jsonToTest.deducible = '3';
        jsonToTest.fechaEvaluacion = '06-09-2021  20:43:48';
        jsonToTest.deducibleInteligente = '0';
        jsonToTest.fechaActualizaciondeducibleInteligente = '06-09-2021  20:43:48';
        jsonToTest.nroOT = '3547973';
        jsonToTest.fechaEnvioOt = '07-09-2021  16:58:16';
        jsonToTest.nroOC = '3547973';
        jsonToTest.fechaEntregaVehiculo = '20-10-2021 00:00:00';
        jsonToTest.fechaGeneracionFiniquito = '20-10-2021 00:00:00';

        /*
        {"tipoEvento": "200","numeroSiniestro":"1212117","idCobertura":"59","nombreCobertura":"DAÑOS MATERIALES A CONSECUENCIA DE ACTOS MALICIOSOS","provision":"18","deducible":"3","idLiquidador":"233","liquidador":"Claudio Fuller P.","rutTaller":"79853470-K","nombreTaller":"AUTOMOTRIZ CORDILLERA S.A.","idInvolucrado":"1","nombreInvolucrado":"Patricia Andrea Espinoza Jara","patente":"PJKL36","fechaEvaluacion":"06-09-2021  20:43:48","deducibleInteligente":"0"}
        {"tipoEvento":"110","numeroSiniestro":"0000000","idInvolucrado":"1","nombreIncolucrado":"isabel correa ariztia","rutInvolucrado":"6379885-1","patente":"HVGK24","fechaRecepcionVehiculo":"09-09-2021 00:00:00"}
        {"tipoEvento": "400","numeroSiniestro":"1212131","idCobertura":"59","nombreCobertura":"DAÑOS AL VEHÍCULO LIVIANO: DAÑOS MATERIALES Y ROBO, HURTO O USO NO AUTORIZADO","nroOT":"3547973","idInvolucrado":"1","nombreInvolucrado":"MAURICIO EDUARDO CABEZA BARRALES","rutInvolucrado":"11984617-K","patente":"JDWD31","fechaEnvioOt":"07-09-2021  16:58:16"}
        {"tipoEvento":"600", "numeroSiniestro":"1212131", "idInvolucrado":"1", "nombreInvolucrado":"FELIPE ANDRES SANZANA ALDUNATE", "rutInvolucrado":"17614902-7", "patente":"KSDF20", "fechaEntregaVehiculo":"20-10-2021 00:00:00"}
        */

        List<HDI_ApiSiniestroJSON.Involucrado> listInvolucrados = new List<HDI_ApiSiniestroJSON.Involucrado>();
        HDI_ApiSiniestroJSON.Involucrado nuevoInvolucrado = new HDI_ApiSiniestroJSON.Involucrado();
        nuevoInvolucrado.idInvolucrado = '1';
        nuevoInvolucrado.nombreTercero = 'tercero';
        nuevoInvolucrado.rutTercero = '77139763-9';
        listInvolucrados.add(nuevoInvolucrado);
        jsonToTest.involucrados = listInvolucrados;

        String myJSON = JSON.serialize(jsonToTest);

        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/case/';
        request.httpMethod = 'POST';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf(myJSON);
        RestContext.request = request;

        Test.startTest();
            list<CaseBot_GetSiniestroEstado.SiniestroInput> orderInputs = new list<CaseBot_GetSiniestroEstado.SiniestroInput>();
            CaseBot_GetSiniestroEstado.SiniestroInput numSiniestro = new CaseBot_GetSiniestroEstado.SiniestroInput();
            numSiniestro.sOrderNumber = null;
            orderInputs.add(numSiniestro);

            CaseBot_GetSiniestroEstado.getSiniestroStatus(orderInputs);

            list<CaseBot_GetSiniestroLiquidador.SiniestroInput> orderInputsLiqui = new list<CaseBot_GetSiniestroLiquidador.SiniestroInput>();
            CaseBot_GetSiniestroLiquidador.SiniestroInput numSiniestroLiqui = new CaseBot_GetSiniestroLiquidador.SiniestroInput();
            numSiniestroLiqui.sOrderNumber = null;
            orderInputsLiqui.add(numSiniestroLiqui);

            CaseBot_GetSiniestroLiquidador.getSiniestroLiquidador(orderInputsLiqui);

            API_Siniestros.create();

            API_Siniestros.create();//Juan Espinoza Leon
            orderInputs[0].sOrderNumber = '1212112';
            CaseBot_GetSiniestroEstado.getSiniestroStatus(orderInputs);

            orderInputsLiqui[0].sOrderNumber = '1212112';
            CaseBot_GetSiniestroLiquidador.getSiniestroLiquidador(orderInputsLiqui);

            jsonToTest.tipoEvento = '110';
            myJSON = JSON.serialize(jsonToTest);
            request.requestBody = Blob.valueOf(myJSON);
            RestContext.request = request;
            API_Siniestros.actualizar();

            jsonToTest.tipoEvento = '200';
            myJSON = JSON.serialize(jsonToTest);
            request.requestBody = Blob.valueOf(myJSON);
            RestContext.request = request;
            API_Siniestros.actualizar();

            jsonToTest.tipoEvento = '200';
            myJSON = JSON.serialize(jsonToTest);
            request.requestBody = Blob.valueOf(myJSON);
            RestContext.request = request;
            API_Siniestros.actualizar();

            jsonToTest.tipoEvento = '111';
            myJSON = JSON.serialize(jsonToTest);
            request.requestBody = Blob.valueOf(myJSON);
            RestContext.request = request;
            API_Siniestros.actualizar();

            jsonToTest.tipoEvento = '210';
            myJSON = JSON.serialize(jsonToTest);
            request.requestBody = Blob.valueOf(myJSON);
            RestContext.request = request;
            API_Siniestros.actualizar();

            jsonToTest.tipoEvento = '400';
            myJSON = JSON.serialize(jsonToTest);
            request.requestBody = Blob.valueOf(myJSON);
            RestContext.request = request;
            API_Siniestros.actualizar();

            jsonToTest.tipoEvento = '500';
            myJSON = JSON.serialize(jsonToTest);
            request.requestBody = Blob.valueOf(myJSON);
            RestContext.request = request;
            API_Siniestros.actualizar();

            jsonToTest.tipoEvento = '600';
            myJSON = JSON.serialize(jsonToTest);
            request.requestBody = Blob.valueOf(myJSON);
            RestContext.request = request;
            API_Siniestros.actualizar();

            jsonToTest.tipoEvento = '700';
            myJSON = JSON.serialize(jsonToTest);
            request.requestBody = Blob.valueOf(myJSON);
            RestContext.request = request;
            API_Siniestros.actualizar();

            jsonToTest.tipoEvento = '1000';
            myJSON = JSON.serialize(jsonToTest);
            request.requestBody = Blob.valueOf(myJSON);
            RestContext.request = request;
            API_Siniestros.actualizar();

            jsonToTest.tipoEvento = '112';
            myJSON = JSON.serialize(jsonToTest);
            request.requestBody = Blob.valueOf(myJSON);
            RestContext.request = request;
            API_Siniestros.actualizar();

            jsonToTest.idCobertura = '';
            myJSON = JSON.serialize(jsonToTest);
            request.requestBody = Blob.valueOf(myJSON);
            RestContext.request = request;
            API_Siniestros.actualizar();

        Test.stopTest();

    }
}