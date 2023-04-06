@RestResource(urlMapping='/case/*')
global without sharing class API_Siniestros {
    @HttpPost
    global static String create(){
        RestRequest req = RestContext.request;
        Blob body = req.requestBody;
        String requestString = body.toString();
        system.debug(requestString);
        string m2 = '';
        HDI_ApiSiniestroJSON co = (HDI_ApiSiniestroJSON) JSON.deserialize(requestString, HDI_ApiSiniestroJSON.class);

        list<ORG_IntegrationLogError__c> logError = new list<ORG_IntegrationLogError__c>();
        BECS_OpportunityAPI.InParameters api = new BECS_OpportunityAPI.InParameters();

        SYSTEM.DEBUG(co);
        list<Case> listCase = new HDI_CaseSelector().selectByNumSiniestro(co.numeroSiniestro);

        if(listCase.isEmpty()){

            String tipoEvento = co.tipoEvento;
            if(tipoEvento == '100'){

                //if (!listEjecutivo.isEmpty()) {
                    Id idTRCaseSiniestro = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Siniestro').getRecordTypeId();
                    list<User> siniestroOwnerDefault = new HDI_UserSelector().selectByFuncion('Jefatura de Liquidadores Flotas');

                    Case caso = new Case();

                    caso.Type = 'Siniestro';
                    caso.Origin = 'Otro';
                    Caso.Status = 'Denuncio';
                    Caso.RecordTypeId = idTRCaseSiniestro;
                    system.debug(co.estadoDenuncio);
                    caso.HDI4I_Estado_del_denuncio__c = co.estadoDenuncio;
                    caso.HDI4I_N_Siniestro__c = co.numeroSiniestro;
                    caso.HDI4I_Ramo__c = co.ramo;
                    caso.HDI4I_Producto__c = co.producto;
                    caso.HDI4I_Poliza__c = co.poliza;
                    caso.HDI4I_Certificado__c = double.valueOf(co.certificado);                 //tipo de dato doble
                    caso.HDI4I_Fecha_de_ocurrencia__c = formatoFecha(co.fechaOcurrencia);           // tipo de dato Date
                    caso.HDI4I_Fecha_de_denuncia__c = formatoFecha(co.fechaDenuncia);       // tipo de dato Date
                    caso.Origin = co.canalDenuncia;
                    caso.HDI4I_Rut_del_asegurado__c = co.rutAsegurado;
                    caso.HDI4I_Nombre_del_asegurado__c = co.nombreAsegurado;
                    caso.SuppliedPhone = '+569'+co.celularAsegurado;
                    caso.SuppliedEmail = co.mailContacto;
                    caso.HDI_CelularAsegurado__c = '+569'+co.celularAsegurado;
                    caso.HDI4I_Nombre_del_conductor__c = co.nombreConductor;
                    caso.HDI4I_Rut_del_conductor__c = co.rutConductor;
                    caso.HDI4I_Marca__c = co.marca;
                    caso.HDI4I_Modelo__c = co.modelo;
                    caso.HDI4I_Ano_del_vehiculo__c = co.anio;
                    caso.HDI4I_Patente_del_vehiculo__c = co.patente;
                    caso.HDI4I_ID_del_liquidador__c = co.idLiquidador;
                    caso.HDI4I_Nombre_del_liquidador__c = co.liquidador;
                    caso.HDI4I_Rut_del_taller__c = co.rutTaller;
                    caso.HDI4I_Nombre_del_taller__c = co.nombreTaller;
                    caso.HDI4I_Relato__c = co.relato;
                    caso.TipoEvento__c = tipoEvento;

                    try{
                        caso.OwnerId = siniestroOwnerDefault[0].id;

                        Database.DMLOptions options = new Database.DMLOptions();
                        options.assignmentRuleHeader.useDefaultRule = false;
                        caso.setOptions(options);
                        insert caso;

                        if(co.involucrados.size() > 0){
                            list<HDI4I_Tercero__c> listNewHDI4ITercero = new list<HDI4I_Tercero__c>();
                            for(HDI_ApiSiniestroJSON.involucrado i : co.involucrados){
                                HDI4I_Tercero__c tercero = new HDI4I_Tercero__c();
                                tercero.HDI4I_Id_involucrado__c = double.valueOf(i.idInvolucrado);
                                tercero.HDI4I_Nombre_tercero__c = i.nombreTercero;
                                tercero.HDI4I_Rut_tercero__c = i.rutTercero;
                                tercero.HDI4I_Siniestro__c = caso.Id;

                                //insert tercero; Mala práctica, comentado por Fran INETUM
                                listNewHDI4ITercero.add(tercero);
                            }
                            insert listNewHDI4ITercero;
                        }

                        m2 = 'OK';

                        // LUCAS LOGS
                        System.debug('HDIAPISINIESTROS JSON'+ co);

                        list<Case> listCaso = new HDI_CaseSelector().selectByNumSiniestro(co.numeroSiniestro);


                        if (!listCaso.isEmpty()){
                            logError.add(BECS_LogErrorTL.fullLog('Success', api, 'Correcto','', co));
                            System.debug('OK API_SINIESTROS');
                        }

                    }catch(DmlException e){
                        m2 = 'ERROR: '+e.getMessage();
                        //Lucas
                        logError.add(BECS_LogErrorTL.fullLog('Error', api, 'No procesado', m2,co));
                    }

            }else{
                m2 = 'no corresponde al tipo de evento';
                //Lucas
                logError.add(BECS_LogErrorTL.fullLog('Error', api, 'No procesado', m2,co));
            }
        }else
        {
            //Juan Espinoza Leon
            Case caso = listCase[0];

          //  caso.Type = 'Siniestro';
            caso.Origin = 'Otro';
           // Caso.Status = 'Denuncio';
           // Caso.RecordTypeId = idTRCaseSiniestro;
            system.debug(co.estadoDenuncio);
           // caso.HDI4I_Estado_del_denuncio__c = co.estadoDenuncio;
            //caso.HDI4I_N_Siniestro__c = co.numeroSiniestro;
            caso.HDI4I_Ramo__c = co.ramo;
            caso.HDI4I_Producto__c = co.producto;
            caso.HDI4I_Poliza__c = co.poliza;
            caso.HDI4I_Certificado__c = double.valueOf(co.certificado);                 //tipo de dato doble
            caso.HDI4I_Fecha_de_ocurrencia__c = formatoFecha(co.fechaOcurrencia);           // tipo de dato Date
            caso.HDI4I_Fecha_de_denuncia__c = formatoFecha(co.fechaDenuncia);       // tipo de dato Date
            //caso.Origin = co.canalDenuncia;
            caso.HDI4I_Rut_del_asegurado__c = co.rutAsegurado;
            caso.HDI4I_Nombre_del_asegurado__c = co.nombreAsegurado;
            //caso.SuppliedPhone = '+569'+co.celularAsegurado;
          //  caso.SuppliedEmail = co.mailContacto;
            caso.HDI_CelularAsegurado__c = '+569'+co.celularAsegurado;
            caso.HDI4I_Nombre_del_conductor__c = co.nombreConductor;
            caso.HDI4I_Rut_del_conductor__c = co.rutConductor;
            caso.HDI4I_Marca__c = co.marca;
            caso.HDI4I_Modelo__c = co.modelo;
            caso.HDI4I_Ano_del_vehiculo__c = co.anio;
            caso.HDI4I_Patente_del_vehiculo__c = co.patente;
            // caso.HDI4I_ID_del_liquidador__c = co.idLiquidador;
            // caso.HDI4I_Nombre_del_liquidador__c = co.liquidador;
            // caso.HDI4I_Rut_del_taller__c = co.rutTaller;
            // caso.HDI4I_Nombre_del_taller__c = co.nombreTaller;
            caso.HDI4I_Relato__c = co.relato;
           // caso.TipoEvento__c = tipoEvento;

           update caso;

            try
            {

                // caso.OwnerId = siniestroOwnerDefault[0].id;

                // Database.DMLOptions options = new Database.DMLOptions();
                // options.assignmentRuleHeader.useDefaultRule = false;
                // caso.setOptions(options);
               // update caso;

                system.debug('@@@@ update case --> '+caso);
                if(co.involucrados.size() > 0){
                    list<HDI4I_Tercero__c> listNewHDI4ITercero = new list<HDI4I_Tercero__c>();
                    for(HDI_ApiSiniestroJSON.involucrado i : co.involucrados){
                        HDI4I_Tercero__c tercero = new HDI4I_Tercero__c();
                        tercero.HDI4I_Id_involucrado__c = double.valueOf(i.idInvolucrado);
                        tercero.HDI4I_Nombre_tercero__c = i.nombreTercero;
                        tercero.HDI4I_Rut_tercero__c = i.rutTercero;
                        tercero.HDI4I_Siniestro__c = caso.Id;

                        //insert tercero; Mala práctica, comentado por Fran INETUM
                        listNewHDI4ITercero.add(tercero);
                    }
                    insert listNewHDI4ITercero;
                }

                m2 = 'OK';

                // LUCAS LOGS
                System.debug('HDIAPISINIESTROS JSON'+ co);

                list<Case> listCaso = new HDI_CaseSelector().selectByNumSiniestro(co.numeroSiniestro);


                if (!listCaso.isEmpty()){
                    logError.add(BECS_LogErrorTL.fullLog('Success', api, 'Correcto','', co));
                    System.debug('OK API_SINIESTROS');
                }

            }catch(DmlException e){
                m2 = 'ERROR: '+e.getMessage();
                system.debug('@@@@ update case m2 --> '+m2);
                logError.add(BECS_LogErrorTL.fullLog('Error', api, 'No procesado', m2,co));
            }
            //Juan Espinoza Leon
            //m2 = 'ERROR: Ya existe N° de siniestro';
            //Lucas
            //logError.add(BECS_LogErrorTL.fullLog('Error', api, 'No procesado', m2,co));
        }
        System.debug('ApiSiniestro: ' +  m2);
        //Lucas
        System.debug('LOG ERROR' + logError);
        new BECS_LogErrorTL(logError).insertLogs(logError);
        return m2;
    }

    @HttpPut
    global static string actualizar(){

        RestRequest req = RestContext.request;
        Blob body = req.requestBody;
        String requestString = body.toString();
        system.debug(requestString);
        String m = 'OK';
        HDI_ApiSiniestroJSON apiSiniestrosJson = (HDI_ApiSiniestroJSON) JSON.deserialize(requestString, HDI_ApiSiniestroJSON.class);
        list<Case> listCase = new HDI_CaseSelector().selectByNumSiniestro(apiSiniestrosJson.numeroSiniestro);

        if(!listCase.isEmpty()){

            String tipoEvento = apiSiniestrosJson.tipoEvento;
            listCase[0].TipoEvento__c = tipoEvento;

            system.debug(tipoEvento);

            // Agregado el 15-02-2023 por Inetum primera fase de solo se requieren 2 eventos, para Whatsapp
            if(tipoEvento == '110'){
                m = recepcionVehiculo(listCase[0], apiSiniestrosJson);
            } else if(tipoEvento == '111'){
                m = asignaReAsigna(listCase[0], apiSiniestrosJson);
            }

            /*
            Comentado el 15-02-2023 por Inetum, primera fase de solo se requieren 2 eventos, para Whatsapp
            se comenta por consiguiente cada método a los que se hace referencia, exceptuando los del 110 y 111

            integer idA = apiSiniestrosJson.idInvolucrado != null ? integer.valueOf(apiSiniestrosJson.idInvolucrado) : 0;
            if((tipoEvento == '110' || tipoEvento == '112' || tipoEvento == '200' || tipoEvento == '400' || tipoEvento == '500' || tipoEvento == '600') && (idA >= 3 || idA == 2)){
                m = 'OK';

            }else if(tipoEvento == '110'){
                m = recepcionVehiculo(listCase[0], apiSiniestrosJson);

            } else if(tipoEvento == '111'){
                m = asignaReAsigna(listCase[0], apiSiniestrosJson);

            } else if(tipoEvento == '112'){
                m = rechazaCobertura(listCase[0], apiSiniestrosJson);

            } else if(tipoEvento == '200'){
                m = segundoEnvio(listCase[0], apiSiniestrosJson);

            } else if(tipoEvento == '210'){
                m = deducibleInteligente(listCase[0], apiSiniestrosJson);

            } else if(tipoEvento == '400'){
                m = enviaOT(listCase[0], apiSiniestrosJson);

            } else if(tipoEvento == '500'){
                m = enviaOC(listCase[0], apiSiniestrosJson);

            } else if(tipoEvento == '600'){
                m = entregaVehiculo(listCase[0], apiSiniestrosJson);

            } else if(tipoEvento == '700'){
                m = generaFiniquito(listCase[0], apiSiniestrosJson);

            } else{
                m = 'Siniestro no existe';
            }*/

        }else{
            m = 'Siniestro no existe';
        }
        System.debug('ApiSiniestro: ' +  m);
        return m;
    }


    //------------------------------------------------------------------------------------ [110] RECEPCIÓN DE VEHÍCULO----------------------------------------------------
    public static String recepcionVehiculo(Case c, HDI_ApiSiniestroJSON json){
        String m = 'OK';
        integer idA = integer.valueOf(json.idInvolucrado);
        c.HDI4I_Fecha_de_recepcion_del_vehiculo__c = formatoFecha(json.fechaRecepcionVehiculo);

        try{
            update c;
        }catch(DmlException e){
            m = 'ERROR: '+e.getMessage();
        }

        return m;
    }

    //------------------------------------------------------------------------------------ [111] ASIGNA O REASIGNA--------------------------------------------------------
    public static String asignaReAsigna(Case c, HDI_ApiSiniestroJSON json){
        string m = 'OK';

        if(c.HDI4I_ID_del_liquidador__c != json.idLiquidador){
            c.HDI4I_Nombre_del_liquidador__c = json.liquidador;
            c.HDI4I_ID_del_liquidador__c = json.idLiquidador;
            c.HDI4I_Fecha_reasignacion_liquidador__c = formatoFecha(json.fechaReasignacionLiquidador);
        }

        if(c.HDI4I_Rut_del_taller__c != json.rutTaller){
            c.HDI4I_Nombre_del_taller__c = json.nombreTaller;
            c.HDI4I_Rut_del_taller__c = json.rutTaller;
            c.HDI4I_Fecha_de_reasignacion_de_taller__c = formatoFecha(json.fechaReasignacionTaller);
        }

        try{
            update c;
        }catch(DmlException e){
            m = 'ERROR: '+e.getMessage();
        }

        // Comentado el 15-02-2023 para dejar únicamente el bloque de arriba que pertenece al "else"
        /* if(json.idCobertura != ''){ //nunca vendrá con cobertura

            HDI4I_Cobertura_del_siniestro__c cob = new HDI_CoberturaSiniestroSelector().selectBySiniestroAndCobertura(c.id, json.idCobertura)[0];

            if(cob.HDI4I_Id_del_liquidador__c != json.idLiquidador){
                c.HDI4I_Nombre_del_liquidador__c = json.liquidador;
                c.HDI4I_ID_del_liquidador__c = json.idLiquidador;
                cob.HDI4I_Fecha_reasignacion_liquidador__c = formatoFecha(json.fechaReasignacionLiquidador);
            }

            if(cob.HDI4I_Rut_taller__c != json.rutTaller){
                cob.HDI4I_Rut_taller__c = json.rutTaller;
                cob.HDI4I_Nombre_taller__c = json.nombreTaller;
                cob.HDI4I_Fecha_reasignacion_taller__c = formatoFecha(json.fechaReasignacionTaller);
            }


            try{
                update cob;
                update c;
                m = 'OK';
            }catch(DmlException e){
                m = 'ERROR: '+e.getMessage();
            }
        }else{

            if(c.HDI4I_ID_del_liquidador__c != json.idLiquidador){
                c.HDI4I_Nombre_del_liquidador__c = json.liquidador;
                c.HDI4I_ID_del_liquidador__c = json.idLiquidador;
                c.HDI4I_Fecha_reasignacion_liquidador__c = formatoFecha(json.fechaReasignacionLiquidador);
            }

            if(c.HDI4I_Rut_del_taller__c != json.rutTaller){
                c.HDI4I_Nombre_del_taller__c = json.nombreTaller;
                c.HDI4I_Rut_del_taller__c = json.rutTaller;
                c.HDI4I_Fecha_de_reasignacion_de_taller__c = formatoFecha(json.fechaReasignacionTaller);
            }

            try{
                update c;
                m = 'OK';
            }catch(DmlException e){
                m = 'ERROR: '+e.getMessage();
            }
        } */
        return m;
    }

    //------------------------------------------------------------------------------------ [112] RECHAZA COBERTURA---------------------------------------------------------------
    /* public static String rechazaCobertura(Case c, HDI_ApiSiniestroJSON json){
        string m = '';

        if(json.idCobertura != ''){
            HDI4I_Cobertura_del_siniestro__c cob = new HDI_CoberturaSiniestroSelector().selectBySiniestroAndCobertura(c.id, json.idCobertura)[0];

            cob.HDI4I_Fecha_de_rechazo__c = formatoFecha(json.fechaRechazo);
            cob.HDI4I_Estado_cobertura__c = 'Rechazada';

            try{
                update cob;
                m = 'OK';
            }catch(DmlException e){
                m = 'ERROR: '+e.getMessage();
            }
        }else{
            m = RechazaCaso(c, json.fechaRechazo);
        }


        return m;
    } */

    //------------------------------------------------------------------------------------ [200] SEGUNDO ENVÍO-------------------------------------------------------------------
    /* public static String segundoEnvio(Case c, HDI_ApiSiniestroJSON json){ // siempre viene con cobertura
        string m = '';

        HDI4I_Cobertura_del_siniestro__c cob;
        Boolean guardarCobertura = false;

        if(json.idCobertura != ''){
            guardarCobertura = true;
            list<HDI4I_Cobertura_del_siniestro__c> listCobertura = new HDI_CoberturaSiniestroSelector().selectBySiniestroAndCobertura(c.id, json.idCobertura);

            system.debug('Hay cobertura');
            if(!listCobertura.isEmpty()){
                system.debug('Cobertura existe');
                cob  = listCobertura[0];
                cob.HDI4I_Provision__c = double.valueOf(json.provision);
                cob.HDI4I_Deducible__c = double.valueOf(json.deducible);
                c.HDI4I_Nombre_del_liquidador__c = json.liquidador;
                c.HDI4I_Estado_del_denuncio__c = 'Evaluado';
                c.HDI4I_Fecha_de_evaluacion__c = formatoFecha(json.fechaEvaluacion);

                if(json.deducibleInteligente == '0'){
                    c.HDI4I_Deducible_inteligente__c = 'No';
                }else if(json.deducibleInteligente == '1'){
                    c.HDI4I_Deducible_inteligente__c = 'Si';
                }

                if(cob.HDI4I_Fecha_de_rechazo__c != null){
                    cob.HDI4I_Fecha_de_rechazo__c = null;
                    cob.HDI4I_Estado_cobertura__c = 'Aprobada';
                }

                if(c.HDI4I_ID_del_liquidador__c != json.idLiquidador){
                    c.HDI4I_Nombre_del_liquidador__c = json.liquidador;
                    c.HDI4I_ID_del_liquidador__c = json.idLiquidador;
                    c.HDI4I_Fecha_reasignacion_liquidador__c = system.now();
                }

                if(c.HDI4I_Rut_del_taller__c != json.rutTaller){
                    c.HDI4I_Nombre_del_taller__c = json.nombreTaller;
                    c.HDI4I_Rut_del_taller__c = json.rutTaller;
                    c.HDI4I_Fecha_de_reasignacion_de_taller__c = system.now();
                }

            }else{
                system.debug('Cobertura no existe');
                cob = new HDI4I_Cobertura_del_siniestro__c();
                cob.HDI4I_Siniestro__c = c.id;
                cob.HDI4I_Id_de_cobertura__c = json.idCobertura;
                cob.HDI4I_Nombre_de_cobertura__c = json.nombreCobertura;
                cob.HDI4I_Rut_taller__c = json.rutTaller;
                cob.HDI4I_Nombre_taller__c = json.nombreTaller;
                cob.HDI4I_Provision__c = double.valueOf(json.provision);
                system.debug(cob.HDI4I_Provision__c);
                cob.HDI4I_Deducible__c = double.valueOf(json.deducible);
                system.debug(cob.HDI4I_Deducible__c);
                c.HDI4I_Nombre_del_liquidador__c = json.liquidador;
                c.HDI4I_ID_del_liquidador__c = json.idLiquidador;
                c.HDI4I_Estado_del_denuncio__c = 'Evaluado';
                c.HDI4I_Fecha_de_evaluacion__c = formatoFecha(json.fechaEvaluacion);
                c.HDI4I_Nombre_del_taller__c = json.nombreTaller;
                c.CurrencyIsoCode = 'CLF';
                cob.CurrencyIsoCode = 'CLF';

                if(json.deducibleInteligente == '0'){
                    c.HDI4I_Deducible_inteligente__c = 'No';
                }else if(json.deducibleInteligente == '1'){
                    c.HDI4I_Deducible_inteligente__c = 'Si';
                }

                cob.HDI4I_Estado_cobertura__c = 'Aprobada';
            }
        }else{
            system.debug('No viene cobertura');
            c.HDI4I_Nombre_del_liquidador__c = json.liquidador;
            c.HDI4I_ID_del_liquidador__c = json.idLiquidador;
            c.HDI4I_Estado_del_denuncio__c = 'Evaluado';
            c.HDI4I_Fecha_de_evaluacion__c = formatoFecha(json.fechaEvaluacion);
            c.HDI4I_Nombre_del_taller__c = json.nombreTaller;
            c.CurrencyIsoCode = 'CLF';

            if(json.deducibleInteligente == '0'){
                c.HDI4I_Deducible_inteligente__c = 'No';
            }else if(json.deducibleInteligente == '1'){
                c.HDI4I_Deducible_inteligente__c = 'Si';
            }

        }

        try{
            if(guardarCobertura){
                upsert cob;
            }
            update c;
            m = 'OK';
        }catch(DmlException e){
            m = 'ERROR: '+e.getMessage();
        }

        return m;
    } */

    //------------------------------------------------------------------------------------ [210] ACTUALIZA DEDUCIBLE INTELIGENTE-----------------------------------------------
    /* public static String deducibleInteligente(Case c, HDI_ApiSiniestroJSON json){
        string m = '';
        c.HDI4I_Fecha_actualiza_deduc_inteligente__c = formatoFecha(json.fechaActualizaciondeducibleInteligente);

        if(json.deducibleInteligente == '0'){
            c.HDI4I_Deducible_inteligente__c = 'No';
        }else if(json.deducibleInteligente == '1'){
            c.HDI4I_Deducible_inteligente__c = 'Si';
        }
        try{
            update c;
            m = 'OK';
        }catch(DmlException e){
            m = 'ERROR: '+e.getMessage();
        }
        return m;
    } */

    //------------------------------------------------------------------------------------ [400] ENVÍO DE OT A TALLER---------------------------------------------------------
    /* public static String enviaOT(Case c, HDI_ApiSiniestroJSON json){
        string m = '';

        HDI4I_Cobertura_del_siniestro__c cob = new HDI_CoberturaSiniestroSelector().selectBySiniestroAndCobertura(c.id, json.idCobertura)[0];
        HDI4I_Orden_trabajo_compra__c ot = new HDI4I_Orden_trabajo_compra__c();

        ot.HDI4I_Cobertura_del_siniestro__c = cob.Id;
        ot.HDI4I_Tipo_de_orden__c = 'Orden de trabajo';
        ot.HDI4I_Numero__c = json.nroOT;
        ot.HDI4I_Fecha_envio_orden_trabajo__c = formatoFecha(json.fechaEnvioOt);

        try{
            insert ot;
            update c;
            m = 'OK';
        }catch(DmlException e){
            m = 'ERROR: '+e.getMessage();
        }

        return m;
    } */

    //------------------------------------------------------------------------------------ [500] ENVÍO DE OC A PROOVEDOR-------------------------------------------------------
    /* public static String enviaOC(Case c, HDI_ApiSiniestroJSON json){
        string m = '';

        HDI4I_Cobertura_del_siniestro__c cob = new HDI_CoberturaSiniestroSelector().selectBySiniestroAndCobertura(c.id, json.idCobertura)[0];
        HDI4I_Orden_trabajo_compra__c oc = new HDI4I_Orden_trabajo_compra__c();

        oc.HDI4I_Cobertura_del_siniestro__c = cob.Id;
        oc.HDI4I_Tipo_de_orden__c = 'Orden de compra';
        oc.HDI4I_Numero__c = json.nroOC;

        try{
            insert oc;
            m = 'OK';
        }catch(DmlException e){
            m = 'ERROR: '+e.getMessage();
        }

        return m;
    } */

    //------------------------------------------------------------------------------------ [600] ENTREGA DE VEHÍCULO------------------------------------------------------------
    /* public static String entregaVehiculo(Case c, HDI_ApiSiniestroJSON json){
        string m = '';
        c.HDI4I_Fecha_de_entrega_vehiculo__c = formatoFecha(json.fechaEntregaVehiculo);

        try{
            update c;
            system.debug('Actualizó 400');
            m = 'OK';
        }catch(DmlException e){
            m = 'ERROR: '+e.getMessage();
        }

        return m;
    } */

    //------------------------------------------------------------------------------------ [700] ENTREGA DE FINIQUITO--------------------------------------------------------------
    /* public static String generaFiniquito(Case c, HDI_ApiSiniestroJSON json){
        string m = 'OK';
        if(json.idCobertura != null && json.idCobertura != ''){
            list<HDI4I_Cobertura_del_siniestro__c> cob = new HDI_CoberturaSiniestroSelector().selectBySiniestroAndCobertura(c.id, json.idCobertura);
            if (!cob.isEmpty()) {

                HDI4I_Orden_trabajo_compra__c oc = new HDI4I_Orden_trabajo_compra__c();

                oc.HDI4I_Cobertura_del_siniestro__c = cob[0].Id;
                oc.HDI4I_Tipo_de_orden__c = 'Finiquito';
                oc.HDI4I_Fecha_generacion_finiquito__c = formatoFecha(json.fechaGeneracionFiniquito);

                try{
                    insert oc;
                    m = 'OK';
                }catch(DmlException e){
                    m = 'ERROR: '+e.getMessage();
                }
            }
        }else{
            c.HDI4I_Fecha_de_generacion_finiquito__c = formatoFecha(json.fechaGeneracionFiniquito);

            try{
                update c;
                m = 'OK';
            }catch(DmlException e){
                m = 'ERROR: '+e.getMessage();
            }
        }

        return m;
    } */


    /* public static String rechazaCaso(Case c, String fecha){
        string m = '';

        c.HDI4I_Estado_del_denuncio__c = 'Rechazado';
        //List<HDI4I_Cobertura_del_siniestro__c> cob = [Select id, HDI4I_Fecha_de_rechazo__c from HDI4I_Cobertura_del_siniestro__c where HDI4I_Siniestro__c =: ca.id];
        List<HDI4I_Cobertura_del_siniestro__c> cob = new HDI_CoberturaSiniestroSelector().selectBySiniestro(c.id);
        for(HDI4I_Cobertura_del_siniestro__c o: cob){
            o.HDI4I_Fecha_de_rechazo__c = formatoFecha(fecha);
            o.HDI4I_Estado_cobertura__c = 'Rechazada';
        }

        try{
            update cob;
            update c;
            m = 'OK';
        }catch(DmlException e){
            m = 'ERROR: '+e.getMessage();
        }
        return m;
    } */

    //---------------------------------------------------MÉTODO QUE LE DA FORMATO A LA FECHA PARA PODER GUARDAR EN SALESFORCE---
    public static datetime formatoFecha(string fe){
        string sFecha = fe.left(10);
        string sHora = fe.right(8);
        string anio = sFecha.right(4);
        string day = sFecha.left(2);
        string dm = sFecha.left(5);
        string mes = dm.right(2);

        String formatoNew = anio+'-'+mes+'-'+day+' '+sHora;
        datetime fecha = datetime.valueOf(formatoNew);

        return fecha;
    }

}