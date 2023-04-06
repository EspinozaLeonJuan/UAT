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
    public override Object doPost(){
        final String nombreMetodo = 'doPost';
        System.debug('Entro al metodo: ' + nombreMetodo);
        HDI_ApiResponseWrapper siniestroResponse = new HDI_ApiResponseWrapper(new List<HDI_ApiResponseWrapper.ERROR>(), new List<HDI_ApiResponseWrapper.SUCCESS>());
        List<HDI_WrapperSiniestros_SIN> listWrapperSin = new List<HDI_WrapperSiniestros_SIN>();
        Map<String, HDI_WrapperSiniestros_SIN> mapaWrapperSiniestros = new Map<String, HDI_WrapperSiniestros_SIN>();
        List<HDI_ApiResponseWrapper.ERROR> listError = new List<HDI_ApiResponseWrapper.ERROR>();
        List<HDI_ApiResponseWrapper.SUCCESS> listSuccess = new List<HDI_ApiResponseWrapper.SUCCESS>();
        Map<String,Case> mapaWrapperSiniestrosCreate = new Map<String,Case>();
        Set<String> setNroSiniestros = new Set<String>();
        List<Case> listSiniestros = new List<Case>();
        List<Case> listSiniestrosCreate = new List<Case>();
        List<HDI4I_Tercero__c> listHdiTercero = new List<HDI4I_Tercero__c>();
        List<Object> listaTotal = new List<Object>();
        //duplicados
        Set<String> setDuplicatedSiniestros = new Set<String>();        
        // Validacion de errro si el siniestro ya existe
        list<User> siniestroOwnerDefault = new HDI_UserSelector().selectByFuncion('Jefatura de Liquidadores Flotas');

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
            List<HDI_WrapperSiniestros_SIN.Tercero> terceros = sinWrapper.terceros;
            String itemSin = JSON.serialize(sinWrapper);
            Map<String, Object> mapaCampos = (Map<String,Object>) JSON.deserializeUntyped(itemSin);
            if (validationFieldsRequired(mapaCampos,sinWrapper.numeroEvento)) {
                setNroSiniestros.add(sinWrapper.numeroSiniestro);                
                mapaWrapperSiniestros.put(sinWrapper.numeroSiniestro, sinWrapper);
                for (HDI_WrapperSiniestros_SIN.Tercero tercero : terceros) {
                    HDI4I_Tercero__c hdiTercero = new HDI4I_Tercero__c();
                    hdiTercero.HDITipoDeTercero__c = tercero.tipo;
                    hdiTercero.HDIRutPropietarioTercero__c = tercero.rutPropietario;
                    hdiTercero.HDIDVDelConductorTercero__c = tercero.dvConductor;
                    hdiTercero.HDI4I_Nombre_tercero__c = tercero.nombreConductor;
                    hdiTercero.HDIApellidosDelConductorTercero__c = tercero.apellidoConductor;
                    hdiTercero.HDICelularConductorTercero__c = tercero.celularConductor;
                    hdiTercero.HDIEmailDelConductorTercero__c = tercero.emailConductor;
                    hdiTercero.HDIDireccionDelConductorTercero__c = tercero.direccionConductor;
                    hdiTercero.HDIRutPropietarioTercero__c = tercero.rutPropietario;
                    hdiTercero.HDIDVDelPropietarioTercero__c = tercero.dvPropietario;
                    hdiTercero.HDINombreDelPropietarioTercero__c = tercero.nombrePropietario;
                    hdiTercero.HDIApellidosDelPropietarioTercero__c = tercero.apellidoPropietario;
                    hdiTercero.HDICelularPropietarioTercero__c = tercero.celularPropietario;
                    hdiTercero.HDIEmailDelPropietarioTercero__c = tercero.emailPropietario;
                    hdiTercero.HDIMarcaModeloDelVehiculoTercero__c = tercero.marcaModelo;
                    hdiTercero.HDIDescripcionMarcaDelVHTercero__c = tercero.descripcionMarcaVehiculo;
                    hdiTercero.HDIAseguradoraDelVehiculoTercero__c = tercero.aseguradoraVehiculo;
                    hdiTercero.HDINPolizaDelVehiculoTercero__c= tercero.numeroPolizaVehiculo;
                    hdiTercero.HDIPatenteDelVehiculoTercero__c = tercero.patenteVehiculo;
                    // add other fields
                    listHdiTercero.add(hdiTercero);
                }
            } else {
                HDI_ApiResponseWrapper.ERROR error = new HDI_ApiResponseWrapper.ERROR('REQUIERED_FIELDS_MISSING: ' + mapaCampos.get('fieldsError'), sinWrapper.numeroSiniestro, 400);
                listError.add(error);
            }
        }
        
        
        if (!setNroSiniestros.isEmpty()) {            
            listSiniestros = getCaso(setNroSiniestros);
            for (String numSiniestro : setNroSiniestros) {                
        
                // Comprobamos si el número de siniestro ya existe en base de datos
                Boolean existsInDB = false;
                for(Case siniestroDB : listSiniestros) {
                    if(siniestroDB.HDI4I_N_Siniestro__c == numSiniestro) {
                        existsInDB = true;
                        HDI_ApiResponseWrapper.ERROR error = new HDI_ApiResponseWrapper.ERROR('DUPLICATED_CASE: El siniestro ya se encuentra en sistema ', numSiniestro + '"', 400);
                        listError.add(error);                    
                        break;
                    }
                }
        
                // Si no existe en base de datos, lo añadimos a la lista de casos nuevos
                if(!existsInDB) {
                            Case siniestro = new Case();
                            HDI_WrapperSiniestros_SIN wrapSin = mapaWrapperSiniestros.get(numSiniestro);
                            siniestro.TipoEvento__c = wrapSin.numeroEvento;
                            siniestro.HDI4I_N_Siniestro__c = numSiniestro;                    
                            siniestro.HDIFechaHoraDeIngresoDenuncio__c = wrapSin.fechaIngresoDenuncio;
                            siniestro.HDI4I_N_Siniestro__c = wrapSin.numeroSiniestro;
                            siniestro.Origin = wrapSin.origenCaso;
                            siniestro.HDI4I_Fecha_de_ocurrencia__c = wrapSin.fechaOcurrencia;
                            siniestro.HDI4I_Nombre_del_asegurado__c = wrapSin.nombreAsegurado;
                            siniestro.HDIApellidosDelAsegurado__c = wrapSin.apellidosAsegurado;
                            siniestro.HDI4I_Rut_del_asegurado__c = wrapSin.rutAsegurado;
                            siniestro.HDIDVDelAsegurado__c = wrapSin.dvAsegurado;
                            siniestro.HDI_CelularAsegurado__c = wrapSin.celularAsegurado;
                            siniestro.HDIEmailDelAsegurado__c = wrapSin.emailAsegurado;
                            siniestro.HDICulpabilidadDelAsegurado__c = wrapSin.culpabilidadAsegurado;
                            siniestro.HDI4I_Poliza__c = wrapSin.numeroPoliza;
                            siniestro.HDI4I_Ramo__c = wrapSin.ramo;
                            siniestro.HDI4I_Producto__c = wrapSin.producto;
                            siniestro.HDI4I_Certificado__c = wrapSin.certificado;
                            siniestro.HDI4I_Nombre_del_conductor__c = wrapSin.nombreConductor;
                            siniestro.HDIApellidosDelConductor__c = wrapSin.apellidosConductor;
                            siniestro.HDI4I_Rut_del_conductor__c = wrapSin.rutConductor;
                            siniestro.HDIDVDelConductor__c = wrapSin.dvConductor;
                            siniestro.HDIMarcaModelo__c = wrapSin.marcaModelo;
                            siniestro.HDI4I_Marca__c = wrapSin.marca;
                            siniestro.HDI4I_Modelo__c = wrapSin.modelo;
                            siniestro.HDI4I_Ano_del_vehiculo__c = wrapSin.anioVehiculo;
                            siniestro.HDI4I_Patente_del_vehiculo__c = wrapSin.patenteVehiculo;
                            siniestro.HDI4I_Relato__c = wrapSin.relato;
                            siniestro.HDIFechaConstancia__c = wrapSin.fechaConstancia;
                            siniestro.HDINumConstancia__c = wrapSin.numeroConstancia;
                            siniestro.HDIComisaria__c = wrapSin.comisaria;
                            siniestro.HDIJuzgado__c = wrapSin.juzgado;
                            siniestro.HDIComuna__c = wrapSin.comuna;
                            siniestro.HDICausaNum__c = wrapSin.causaNumero;
                            siniestro.HDIFechaCitacion__c = wrapSin.fechaCitacion;
                            siniestro.HDILesionados__c = wrapSin.lesionados;
                            siniestro.HDICentroAsistencial__c = wrapSin.centroAsistencial;
                            siniestro.HDIAlcoholemia__c = wrapSin.alcoholemia;
                            siniestro.HDINombreDelDenunciante__c = wrapSin.nombreDenunciante;
                            siniestro.HDIApellidosDelDenunciante__c = wrapSin.apellidosDenunciante;
                            siniestro.HDIEmailDelDenunciante__c = wrapSin.emailDenunciante;
                            siniestro.OwnerId = siniestroOwnerDefault[0].id;
                            siniestro.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName()
                            .get('HDI_Siniestro_SIN')
                            .getRecordTypeId(); 
                            //ASIGNAR TERCEROS
                            listSiniestrosCreate.add(siniestro);

                            siniestroResponse.listSuccess.add(new HDI_ApiResponseWrapper.SUCCESS('',siniestro.HDI4I_N_Siniestro__c,200 )); 
                }
            }
        }
        
        // Insertar nuevos casos en base de datos
        if (!listSiniestrosCreate.isEmpty()) {
            try {
                Database.SaveResult[] resultsCaseCreate = Database.insert(listSiniestrosCreate, false);
                for (Integer i = 0; i < resultsCaseCreate.size(); i++) {
                    if (!resultsCaseCreate[i].isSuccess()) {
                        siniestroResponse.listError.add(new HDI_ApiResponseWrapper.ERROR('ERROR_UPDATE_CASE: "' + resultsCaseCreate[i].getErrors() + '"', JSON.serialize(mapaWrapperSiniestrosCreate.get(listSiniestrosCreate[i].Id), true), 400));
                        siniestroResponse.listSuccess.add(new HDI_ApiResponseWrapper.SUCCESS('NEW_CASE: "' + JSON.serialize(mapaWrapperSiniestrosCreate.get(listSiniestrosCreate[i].Id), true), listSiniestrosCreate[i].Id, 200));
                    
                    } else {
                        HDI_ApiResponseWrapper.SUCCESS sucess = new HDI_ApiResponseWrapper.SUCCESS(listSiniestrosCreate[i].HDI4I_N_Siniestro__c,'Siniestro creado correctamente : ' + listSiniestrosCreate[i].HDI4I_N_Siniestro__c, 200);   
                        listSuccess.add(sucess);
                    }
                }
            } catch (DmlException e) {
                for (Integer i = 0; i < e.getNumDml(); i++) {
                    Integer index = e.getDmlIndex(i);
                    siniestroResponse.listError.add(new HDI_ApiResponseWrapper.ERROR('ERROR_UPDATE_CASE: "' + e.getDmlMessage(i) + '"', JSON.serialize(mapaWrapperSiniestrosCreate.get(listSiniestrosCreate[index].Id), true), 400));
                    siniestroResponse.listSuccess.add(new HDI_ApiResponseWrapper.SUCCESS('NEW_CASE: "' + e.getDmlMessage(i) + '"', JSON.serialize(mapaWrapperSiniestrosCreate.get(listSiniestrosCreate[index].Id), true), 200));
                }
            }
        }
        

        System.debug('Salio del metodo: ' + nombreMetodo);
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
        return siniestroResponse;
    
          
    }
    public List<Case> getCaso(Set<String> nsin){
        HDI_CaseSelector selector = new HDI_CaseSelector();        
        List<Case> lista = selector.selectByNumSin(nsin);
        return lista;
    }
    /**
     * Overrride method to manage the update of the case
    */
    public override Object doPut(){

        final String nombreMetodo = 'doPut';
        System.debug('Entro al metodo: ' + nombreMetodo);

        HDI_ApiResponseWrapper siniestroResponse = new HDI_ApiResponseWrapper(new List<HDI_ApiResponseWrapper.ERROR>(), new List<HDI_ApiResponseWrapper.SUCCESS>());
        //manejo de errores
        List<HDI_ApiResponseWrapper.ERROR> listError = new List<HDI_ApiResponseWrapper.ERROR>();
        List<HDI_ApiResponseWrapper.SUCCESS> listSuccess = new List<HDI_ApiResponseWrapper.SUCCESS>();

        List<HDI_WrapperSiniestros_SIN> listWrapperSin = new List<HDI_WrapperSiniestros_SIN>();
        Map<String, HDI_WrapperSiniestros_SIN> mapaWrapperSiniestros = new Map<String, HDI_WrapperSiniestros_SIN>();
        Map<String, HDI_WrapperSiniestros_SIN> mapaWrapperSiniestrosUpdate = new Map<String, HDI_WrapperSiniestros_SIN>();
        Set<String> setNroSiniestros = new Set<String>();
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
                mapaWrapperSiniestros.put(sinWrapper.numeroSiniestro, sinWrapper);
            } else {
                HDI_ApiResponseWrapper.ERROR error = new HDI_ApiResponseWrapper.ERROR('REQUIERED_FIELDS_MISSING: ' + mapaCampos.get('fieldsError'), sinWrapper.numeroSiniestro, 400);
                listError.add(error);
            }
        } 

        if (!setNroSiniestros.isEmpty()) {
            
            listSiniestros = getCaso(setNroSiniestros);

            if (!listSiniestros.isEmpty()) {
                for (Case sin : listSiniestros) {
                    HDI_WrapperSiniestros_SIN sinWrapp = mapaWrapperSiniestros.get(sin.HDI4I_N_Siniestro__c);
                    if (sinWrapp != null) {

                        //mapaWrapperSiniestros.remove(sinWrapp.numeroSiniestro);

                        Case siniestro = new Case(Id = sin.Id);
                        siniestro.HDI4I_N_Siniestro__c = sinWrapp.numeroSiniestro; 
                        siniestro.HDI4I_Fecha_reasignacion_liquidador__c = sinWrapp.fechaAsignacion;
                        siniestro.HDI4I_ID_del_liquidador__c = sinWrapp.idLiquidador != null ? String.valueOf(sinWrapp.idLiquidador) : null;
                        siniestro.HDITipoDeLiquidador__c = sinWrapp.tipoLiquidador;
                        siniestro.HDITelefonoLiquidador__c = sinWrapp.telefonoLiquidador;
                        siniestro.HDI4I_Rut_del_taller__c = sinWrapp.rutTaller;
                        siniestro.HDIDVDelTaller__c = sinWrapp.dvTaller;
                        siniestro.HDI4I_Nombre_del_taller__c = sinWrapp.nombreTaller;
                        siniestro.HDISucursalDelTaller__c = sinWrapp.sucursalTaller;
                        siniestro.HDIDireccionDelTaller__c = sinWrapp.direccionTaller;
                        siniestro.HDINumeroDeContactoDelTaller__c = sinWrapp.telefonoTaller;
                        siniestro.HDIEmailDelTaller__c = sinWrapp.emailTaller;
                        siniestro.HDIIDEjecutivo__c = sinWrapp.idEjecutivo != null ? String.valueOf(sinWrapp.idEjecutivo) : null;
                        siniestro.HDIIdDelAsesor__c = sinWrapp.idAsesor != null ? String.valueOf(sinWrapp.idAsesor) : null;
                        siniestro.HDITelefonoAsesor__c = sinWrapp.telefonoAsesor; 
                        listSiniestrosUpdate.add(siniestro);
                        mapaWrapperSiniestrosUpdate.put(siniestro.Id, sinWrapp);

                    }
                }
            }

            if (!mapaWrapperSiniestros.values().isEmpty()) {
                for (HDI_WrapperSiniestros_SIN item : mapaWrapperSiniestros.values()) {
                    HDI_ApiResponseWrapper.ERROR error = new HDI_ApiResponseWrapper.ERROR('NOT_EXIST_SINIESTRO_WITH_NROSINIESTRO: '+ item.numeroSiniestro, JSON.serialize(item.numeroSiniestro,true), 400);
                    listError.add(error);
                }
            }
        }

        if (!listSiniestrosUpdate.isEmpty()) {
            try {
                Database.SaveResult[] resultsCaseUpdate = Database.insert(listSiniestrosUpdate, false);
                for (Integer i = 0; i < resultsCaseUpdate.size(); i++) {
                    if (!resultsCaseUpdate[i].isSuccess()) {
                        siniestroResponse.listError.add(new HDI_ApiResponseWrapper.ERROR('ERROR_UPDATE_CASE: "' + resultsCaseUpdate[i].getErrors() + '"', JSON.serialize(mapaWrapperSiniestrosUpdate.get(listSiniestrosUpdate[i].Id), true), 400));
                        siniestroResponse.listSuccess.add(new HDI_ApiResponseWrapper.SUCCESS('' +listSiniestrosUpdate[i].HDI4I_N_Siniestro__c, listSiniestrosUpdate[i].HDI4I_N_Siniestro__c, 200));
                    
                    } else {
                        HDI_ApiResponseWrapper.SUCCESS sucess = new HDI_ApiResponseWrapper.SUCCESS(listSiniestrosUpdate[i].HDI4I_N_Siniestro__c,'Siniestro creado correctamente : ' + listSiniestrosUpdate[i].HDI4I_N_Siniestro__c, 200);   
                        listSuccess.add(sucess);
                    }
                }
            } catch (DmlException e) {
                for (Integer i = 0; i < e.getNumDml(); i++) {
                    Integer index = e.getDmlIndex(i);
                    siniestroResponse.listError.add(new HDI_ApiResponseWrapper.ERROR('ERROR_UPDATE_CASE: "' + e.getDmlMessage(i) + '"', JSON.serialize(mapaWrapperSiniestrosUpdate.get(listSiniestrosUpdate[index].Id), true), 400));
                    siniestroResponse.listSuccess.add(new HDI_ApiResponseWrapper.SUCCESS('' + e.getDmlMessage(i) + '"', JSON.serialize(mapaWrapperSiniestrosUpdate.get(listSiniestrosUpdate[index].Id), true), 200));
                }
            }
        }
        if (listError.size()>0){
            siniestroResponse.listError=listError;
            RestContext.response.statusCode = 400;
        }else{
            RestContext.response.statusCode = 200;
        }
        System.debug('Salio del metodo: ' + nombreMetodo);

        RestResponse resp = new RestResponse();
        resp.responseBody = Blob.valueOf(JSON.serialize(siniestroResponse));      
        return siniestroResponse;
    } 

    private static Boolean validationFieldsRequired(Map<String, Object> camposRequest, Object tipoEvento){

        final String nombreMetodo = 'validationFieldsRequired';
        System.debug('Entro al metodo: ' + nombreMetodo);

        Boolean condicion = true;
        String evento = (String)tipoEvento;

        Web_Service_Requiered_Field__mdt camposObligatorios = [SELECT Label, Fields_Siniestro__c FROM Web_Service_Requiered_Field__mdt WHERE Label =: evento];

        List <String> siniestroCampos = camposObligatorios.Fields_Siniestro__c.split(',');
        System.debug('ENTRO A VALIDAR CAMPOS');
        Set<String> missingFields = new Set<String>();

        for(String campo : siniestroCampos){

            String field = campo.uncapitalize();

            if(camposRequest.get(field) == '' || camposRequest.get(field) == null || camposRequest.get(field) == 'null'){

                System.debug('CAMPO QUE FALLO: ' + field);
                System.debug('VALOR CAMPO: ' + camposRequest.get(field));
                condicion = false;
                missingFields.add(field);
            }

        }

        camposRequest.put('fieldsError', String.join(new List<String>(missingFields), ', '));

        System.debug('Salio del metodo: ' + nombreMetodo);
        return condicion;

    }

}