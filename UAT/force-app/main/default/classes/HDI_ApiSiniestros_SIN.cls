/**********************************************************************
 Name:  HDI_CaseSelector()
 Copyright © 2023  INETUM
 ======================================================
======================================================
Purpose:                                                            
This class its the main api entry to manage Siniestros                                                         
======================================================
======================================================
History                                                            
-------                                                            
VERSION  AUTHOR            DATE              DETAIL            Description
   1.0   Jeff Velasquez  07/03/2023      SINIESTROS SIN        Siniestros     
***********************************************************************/
public with sharing class HDI_ApiSiniestros_SIN extends HDI_RestRoute  {

    /**
     * Constructor
    */
    public HDI_ApiSiniestros_SIN() {}
    
    /**
     * Overrride method to manage the creation of the case, only EVENT 100 is available
    */
    public  override Object doPost(){
        
        final String nombreMetodo = 'doPost';
        System.debug('Entro al metodo: ' + nombreMetodo);
        HDI_ApiResponseWrapper siniestroResponse = new HDI_ApiResponseWrapper(new List<HDI_ApiResponseWrapper.ERROR>(), new List<HDI_ApiResponseWrapper.SUCCESS>());
        List<HDI_WrapperSiniestros_SIN> listWrapperSin = new List<HDI_WrapperSiniestros_SIN>();
        Map<String, HDI_WrapperSiniestros_SIN> mapaWrapperSiniestros = new Map<String, HDI_WrapperSiniestros_SIN>();
        List<HDI_ApiResponseWrapper.ERROR> listError = new List<HDI_ApiResponseWrapper.ERROR>();
        List<HDI_ApiResponseWrapper.SUCCESS> listSuccess = new List<HDI_ApiResponseWrapper.SUCCESS>();
        Set<String> setNroSiniestros = new Set<String>();
        List<HDI_WrapperSiniestros_SIN> listWrapper = new List<HDI_WrapperSiniestros_SIN>();
        Map<string,Case> mapaCasoSiniestros = new Map<string,Case>();
        List<HDI4I_Tercero__c> listTercerosUpdate = new List<HDI4I_Tercero__c>();
        Map<String, List<HDI4I_Tercero__c>> mapaterceros = new Map<String, List<HDI4I_Tercero__c>>();
        HDI_ApiSiniestros_Helper helper = new HDI_ApiSiniestros_Helper();
        List<ORG_IntegrationLogError__c> logError = new List<ORG_IntegrationLogError__c>();

        // Deserialize the request body
        try {
            listWrapperSin = (List<HDI_WrapperSiniestros_SIN>) JSON.deserialize(
                RestContext.request.requestBody.toString(),
                List<HDI_WrapperSiniestros_SIN>.class
            );
        } catch (Exception e) {
            throw new HDI_RestRouteError.RestException(
                'Error en la conversion del JSON: ' + e.getMessage(),
                'ERROR_EXECUTION_EXEPTION',
                500,
                null
            );
        }

        // Check if the list is null before performing any operations on it
        if (listWrapperSin == null) {
            throw new HDI_RestRouteError.RestException(
                'Error al convertir el JSON en una lista de objetos HDI_WrapperSiniestros_SIN',
                'ERROR_EXECUTION_EXEPTION',
                500,
                null
            );
        }

        for (HDI_WrapperSiniestros_SIN sinWrapper : listWrapperSin) {
            String itemSin = JSON.serialize(sinWrapper);
            Map<String, Object> mapaCampos = (Map<String,Object>) JSON.deserializeUntyped(itemSin);
            if (validationFieldsRequired(mapaCampos,sinWrapper.numeroEvento)) {
                setNroSiniestros.add(sinWrapper.numeroSiniestro);                
                mapaWrapperSiniestros.put(sinWrapper.numeroSiniestro, sinWrapper);
            } else {
                HDI_ApiResponseWrapper.ERROR error = new HDI_ApiResponseWrapper.ERROR('REQUIERED_FIELDS_MISSING: ' + mapaCampos.get('fieldsError'), sinWrapper.numeroSiniestro, 400);
                logError.add(BECS_LogErrorTL.siniestroLogError('REQUIERED_FIELDS_MISSING: '+ mapaCampos.get('fieldsError'), sinWrapper));
                listError.add(error);
               
            }
        }
        for (String numSiniestro : setNroSiniestros) {
            HDI_WrapperSiniestros_SIN wrapSin = mapaWrapperSiniestros.get(numSiniestro);
            List<HDI_WrapperSiniestros_SIN.Tercero> terceros = wrapSin.terceros;
            Case siniestro = helper.processSIN(wrapSin);
            listWrapper.add(wrapSin);
            mapaCasoSiniestros.put(numSiniestro, siniestro);
        
            List<HDI4I_Tercero__c> listTerceros = new List<HDI4I_Tercero__c>();
            for (HDI_WrapperSiniestros_SIN.Tercero terceroWrap : terceros) {  
                listTerceros.add(helper.processTercero(terceroWrap,wrapSin));
            }
            mapaterceros.put(numSiniestro, listTerceros);
        }
        //guardamos en bbdd
        try {
            Database.UpsertResult[] resultsSiniestros = Database.upsert(mapaCasoSiniestros.values(), Case.Fields.HDI4I_N_Siniestro__c, false);
            for (Integer i = 0; i < resultsSiniestros.size(); i++) {
                if (resultsSiniestros[i].getErrors().size() >0){
                    siniestroResponse.listError.add(new HDI_ApiResponseWrapper.ERROR('Error al crear o actualizar el siniestro: ' + resultsSiniestros[i].getErrors(), mapaCasoSiniestros.values()[i].HDI4I_N_Siniestro__c,400)); 
                    logError.add(BECS_LogErrorTL.siniestroLogError(resultsSiniestros[i].getErrors().toString(),listWrapper[i]));
                } else if (resultsSiniestros[i].isCreated()) {
                    siniestroResponse.listSuccess.add(new HDI_ApiResponseWrapper.SUCCESS('',mapaCasoSiniestros.values()[i].HDI4I_N_Siniestro__c, 200));
                } else if (resultsSiniestros[i].isSuccess() && !resultsSiniestros[i].isCreated()){
                    siniestroResponse.listSuccess.add(new HDI_ApiResponseWrapper.SUCCESS('El siniestro con el numero ' +mapaCasoSiniestros.values()[i].HDI4I_N_Siniestro__c + ' se encontro en base de datos y se actualizo ' ,mapaCasoSiniestros.values()[i].HDI4I_N_Siniestro__c, 200));
                }
            }
        } catch (Exception e) {
            siniestroResponse.listError.add(new HDI_ApiResponseWrapper.ERROR('Error al crear o actualizar el siniestro: ' + e.getMessage(), mapaCasoSiniestros.values().HDI4I_N_Siniestro__c,400));
        }
        
        // actualizar los terceros con los IDs asignados por Salesforce
        for (List<HDI4I_Tercero__c> listTerceros : mapaterceros.values()) {
            for (HDI4I_Tercero__c tercero : listTerceros) {
                tercero.HDI4I_Siniestro__c = mapaCasoSiniestros.get(tercero.HDINumeroSiniestro__c).Id;
                listTercerosUpdate.add(tercero);
            }   
        }
        Database.UpsertResult[] resultsTerceros = Database.upsert(listTercerosUpdate, HDI4I_Tercero__c.HDITerceroInvId__c, false);
        RestResponse response = new RestResponse();
        //chequeamos si la lista de error tiene datos para enviar una respuesta 400       
        if (listError.size()>0){
            siniestroResponse.listError=listError;
            RestContext.response.statusCode = 400;
        }else{
            RestContext.response.statusCode = 200;
        }
        RestContext.response.responseBody = Blob.valueOf(JSON.serialize(siniestroResponse));
        Map<String, Object> responseMap = new Map<String, Object>();
        responseMap = siniestroResponse.toMap();
        if (!logError.isEmpty()) {
            new BECS_LogErrorTL(logError).insertLogs(logError);
        }
        return responseMap;
    }
    
    /**
     * Overrride method to manage the update of the case
    */
    public override Object doPut(){

        final String nombreMetodo = 'doPut';
        System.debug('Entro al metodo: ' + nombreMetodo);

        HDI_ApiResponseWrapper siniestroResponse = new HDI_ApiResponseWrapper(new List<HDI_ApiResponseWrapper.ERROR>(), new List<HDI_ApiResponseWrapper.SUCCESS>());
        HDI_ApiSiniestros_Helper helper = new HDI_ApiSiniestros_Helper();
        List<ORG_IntegrationLogError__c> logError = new List<ORG_IntegrationLogError__c>();

        List<HDI_WrapperSiniestros_SIN> listWrapperSin = new List<HDI_WrapperSiniestros_SIN>();
        Map<String, HDI_WrapperSiniestros_SIN> mapaWrapperSiniestros = new Map<String, HDI_WrapperSiniestros_SIN>();
        Map<String, HDI_WrapperSiniestros_SIN> mapaWrapperSiniestrosUpdate = new Map<String, HDI_WrapperSiniestros_SIN>();
        Map<String, User> mapaUser = new Map<String, User>();
        Set<String> setNroSiniestros = new Set<String>();
        Set<String> setIds = new Set<String>();
        List<User> listUser = new List<User>();
        List<Case> listSiniestros = new List<Case>();
        List<Case> listSiniestrosUpdate = new List<Case>();

        try{
            listWrapperSin = (List<HDI_WrapperSiniestros_SIN>) JSON.deserialize(
            request.requestBody.toString(),
            List<HDI_WrapperSiniestros_SIN>.class
            );
        } catch (JSONException e) {
            System.debug('JSONException: ' + e.getCause());
            throw new HDI_RestRouteError.RestException(
                'Error en la conversion del JSON: ' + e.getMessage(),
                'ERROR_EXECUTION_EXEPTION',
                500,
                null
            );
        }

        for (HDI_WrapperSiniestros_SIN sinWrapper : listWrapperSin) {
            String itemSin = JSON.serialize(sinWrapper);
            Map<String, Object> mapaCampos = (Map<String,Object>) JSON.deserializeUntyped(itemSin);
            if (validationFieldsRequired(mapaCampos,sinWrapper.numeroEvento)) {
                setNroSiniestros.add(sinWrapper.numeroSiniestro);

                if (!String.isEmpty(sinWrapper.idLiquidador) &&
                (sinWrapper.numeroEvento == HDI_ApiSiniestros_Helper.EVENTO_ASIGNACION || sinWrapper.numeroEvento == HDI_ApiSiniestros_Helper.EVENTO_REASIGNACION)) {
                    setIds.add(sinWrapper.idLiquidador);
                }
                if (!String.isEmpty(sinWrapper.idEjecutivo) &&
                (sinWrapper.numeroEvento == HDI_ApiSiniestros_Helper.EVENTO_ASIGNACION || sinWrapper.numeroEvento == HDI_ApiSiniestros_Helper.EVENTO_REASIGNACION)) {
                    setIds.add(sinWrapper.idEjecutivo);
                }
                if (!String.isEmpty(sinWrapper.idAsesor) &&
                (sinWrapper.numeroEvento == HDI_ApiSiniestros_Helper.EVENTO_ASIGNACION || sinWrapper.numeroEvento == HDI_ApiSiniestros_Helper.EVENTO_REASIGNACION)) {
                    setIds.add(sinWrapper.idAsesor);
                }
            
                mapaWrapperSiniestros.put(sinWrapper.numeroSiniestro, sinWrapper);
            } else {
                siniestroResponse.listError.add(new HDI_ApiResponseWrapper.ERROR('REQUIERED_FIELDS_MISSING: '+ mapaCampos.get('fieldsError'), JSON.serialize(sinWrapper.numeroSiniestro,true), 400));
                logError.add(BECS_LogErrorTL.siniestroLogError('REQUIERED_FIELDS_MISSING: '+ mapaCampos.get('fieldsError'), sinWrapper));
            }
        }

        try{

            if (!setIds.isEmpty()){
                listUser = [SELECT Id, Name, HDI4I_LiquidadorId__c FROM User WHERE HDI4I_LiquidadorId__c IN: setIds AND IsActive = TRUE];
            } 

            if (!listUser.isEmpty()){
                for (User usu : listUser) {
                    mapaUser.put(usu.HDI4I_LiquidadorId__c, usu);
                }
            }
        
            if (!setNroSiniestros.isEmpty()){
                listSiniestros = getCaso(setNroSiniestros);
            }
                
            if (!listSiniestros.isEmpty()){
                for (Case sin : listSiniestros) {
                    HDI_WrapperSiniestros_SIN sinWrapp = mapaWrapperSiniestros.get(sin.HDI4I_N_Siniestro__c);
                    if (sinWrapp != null) {

                        mapaWrapperSiniestros.remove(sinWrapp.numeroSiniestro);

                        Case siniestroUpdate = helper.updateSiniestro(sinWrapp, sin, mapaUser);
                        
                        listSiniestrosUpdate.add(siniestroUpdate);
                        mapaWrapperSiniestrosUpdate.put(siniestroUpdate.Id, sinWrapp);

                    }
                }
            }

            if (!mapaWrapperSiniestros.values().isEmpty()) {
                for (HDI_WrapperSiniestros_SIN item : mapaWrapperSiniestros.values()) {
                    siniestroResponse.listError.add(new HDI_ApiResponseWrapper.ERROR('NOT_EXIST_SINIESTRO_WITH_NROSINIESTRO: '+ item.numeroSiniestro, JSON.serialize(item,true), 400));
                    logError.add(BECS_LogErrorTL.siniestroLogError('NOT_EXIST_SINIESTRO_WITH_NROSINIESTRO', item));
                }
            }

        } catch(QueryException e) {
            System.debug('QueryException:  en SOQL QUERY');
            System.debug('QueryException: ' + e.getCause());
            System.debug('QueryException: ' + e.getLineNumber());
        }

        if (!listSiniestrosUpdate.isEmpty()) {
            Database.SaveResult[] resultsCaseUpdate = Database.update(listSiniestrosUpdate, false);
            for (Integer i = 0; i < resultsCaseUpdate.size(); i++) {
                if (!resultsCaseUpdate[i].isSuccess()) {
                    siniestroResponse.listError.add(new HDI_ApiResponseWrapper.ERROR('ERROR_UPDATE_CASE: "' + resultsCaseUpdate[i].getErrors() + '"', JSON.serialize(mapaWrapperSiniestrosUpdate.get(listSiniestrosUpdate[i].Id), true), 400));
                    logError.add(BECS_LogErrorTL.siniestroLogError(resultsCaseUpdate[i].getErrors().toString(), mapaWrapperSiniestrosUpdate.get(listSiniestrosUpdate[i].Id)));
                } else {
                    siniestroResponse.listSuccess.add(new HDI_ApiResponseWrapper.SUCCESS(resultsCaseUpdate[i].Id, 
                    JSON.serialize(mapaWrapperSiniestrosUpdate.get(listSiniestrosUpdate[i].Id).numeroSiniestro, true), 200));
                }
            }
        }

        System.debug('Salio del metodo: ' + nombreMetodo);

        RestResponse resp = new RestResponse();
        resp.responseBody = Blob.valueOf(JSON.serialize(siniestroResponse));

        if (!logError.isEmpty()) {
            new BECS_LogErrorTL(logError).insertLogs(logError);
        }

        return siniestroResponse;
    }

    private static Boolean validationFieldsRequired(Map<String, Object> camposRequest, Object tipoEvento){

        final String nombreMetodo = 'validationFieldsRequired';
        System.debug('Entro al metodo: ' + nombreMetodo);

        Boolean condicion = true;
        String evento = (String)tipoEvento;
        Set<String> missingFields = new Set<String>();

        if (tipoEvento == null || tipoEvento == '') {
            missingFields.add('numeroEvento');
            condicion = false;
        } else {

            Web_Service_Requiered_Field__mdt camposObligatorios = [SELECT Label, Fields_Siniestro__c FROM Web_Service_Requiered_Field__mdt WHERE Label =: evento];

            List <String> siniestroCampos = camposObligatorios.Fields_Siniestro__c.split(',');
            System.debug('ENTRO A VALIDAR CAMPOS');
            
            for(String campo : siniestroCampos){

                String field = campo.uncapitalize();

                if(camposRequest.get(field) == '' || camposRequest.get(field) == null || camposRequest.get(field) == 'null'){

                    System.debug('CAMPO QUE FALLO: ' + field);
                    System.debug('VALOR CAMPO: ' + camposRequest.get(field));
                    condicion = false;
                    missingFields.add(field);
                }

            }

        }

        camposRequest.put('fieldsError', String.join(new List<String>(missingFields), ', '));
        System.debug('Salio del metodo: ' + nombreMetodo);

        return condicion;
    }

    public static List<Case> getCaso(Set<String> nsin){
        HDI_CaseSelector selector = new HDI_CaseSelector();        
        List<Case> lista = selector.selectCaseWithTerceros(nsin);
        return lista;
    }

}