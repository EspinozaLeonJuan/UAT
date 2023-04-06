@RestResource(urlMapping='/v2/opportunity/*')
global without sharing class BECS_OpportunityAPI {
    
    @HttpPost    
    global static String create(){
        RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;

        list<Opportunity> listOpportunities = new list<Opportunity>();
        list<InParameters> listParameters = new list<InParameters>();

        list<Result> listResultados = new list<Result>();
        Result resultado = new Result();

        try {
            System.debug(req.requestBody.toString());
            listParameters = (List<InParameters>) System.JSON.deserialize(req.requestBody.toString(), List<InParameters>.class);
            System.debug('listParameters:'+listParameters);
            Set<String> setidHdiOpWeb = new Set<String>();
            Set<String> setRUTs = new Set<String>();
            Set<String> setCampanas = new Set<String>();
            Set<String> setNumCuenta = new Set<String>();
            List<Account> listAccounts = new List<Account>();
            List<FinServ__FinancialAccount__c> listFinancialAccounts = new List<FinServ__FinancialAccount__c>();

            for(InParameters item : listParameters){
                
                listAccounts.add(BECS_Account.fullAccount(item.nombreCliente, item.apellidoPaterno, item.rutDuenioVehiculo, item.emailCliente, item.telefonoCliente, item.digitoVerificadorRutDuenioVeh));
                if (item.rutDuenioVehiculo != item.rutCliente) {
                    listAccounts.add(BECS_Account.fullAccount(item.rutCliente, item.rutCliente, item.rutCliente, item.emailCliente, item.telefonoCliente, item.digitoVerificadorRutCliente));    
                }

                if(item.numeroTarjeta != null && item.numeroTarjeta != '0' & item.numeroTarjeta != ''){
                    listFinancialAccounts.add(BECS_FinancialAccount.fullFinancialAccount(item.rutCliente, item.banco, item.numeroTarjeta, item.sucursal, 'BECS_DatosBancarios'));
                    setNumCuenta.add(item.numeroTarjeta);
                }
                if(item.numeroCuenta != null && item.numeroCuenta != '0' & item.numeroCuenta != ''){
                    listFinancialAccounts.add(BECS_FinancialAccount.fullFinancialAccount(item.rutCliente, item.banco, item.numeroCuenta, item.sucursal, 'BECS_DatosBancarios'));
                    setNumCuenta.add(item.numeroCuenta);
                }
                /* if(item.productoSeleccionado != null){
                    listFinancialAccountsPolicity.add(BECS_FinancialAccount.fullFinancialAccount(item.rutCliente, null, item.productoSeleccionado, null, 'InsurancePolicy', item.autoReemplazo, item.deducible, item.resposabilidadCivilOp, item.primaCotizacionVehiculo));
                    setNumCuenta.add(item.productoSeleccionado);
                } */
                
                setidHdiOpWeb.add(item.idHdiOpWeb);
                setRUTs.add(item.rutDuenioVehiculo);
                setRUTs.add(item.rutCliente);
                setCampanas.add(item.campaniaCotizadorWeb);
            }

            new BECS_Account(listAccounts).upsertAccountByRut(listAccounts);
            Map<String, Account> mapClientes = new BECS_AccountSelector().selectByRUT(setRUTs);
            Map<String, Campaign> mapCampanas = new BECS_CampanaSelector().selectByIdCampanaCotizadorWeb(setCampanas);

            new BECS_FinancialAccount(listFinancialAccounts).upsertFinancialAccount(listFinancialAccounts);
            Map<String, FinServ__FinancialAccount__c> mapCuentaFinanciera = new Map<String, FinServ__FinancialAccount__c>();
            if (!setNumCuenta.isEmpty()) {
                mapCuentaFinanciera = new BECS_FinancialAccountSelector().selectByNumCuenta(setNumCuenta);    
            }

            Map<String, Opportunity> mappExistingOpps = new BECS_OpportunitySelector().selectByIdWeb(setidHdiOpWeb);
        
            for(InParameters item : listParameters){
                Opportunity newOpp = new Opportunity();
                if (mappExistingOpps.containsKey(item.idHdiOpWeb)) {
                    newOpp = mappExistingOpps.get(item.idHdiOpWeb);    
                }else {
                    newOpp.Name = item.idHdiOpWeb;
                    newOpp.StageName = 'Nuevo';  
                    newOpp.LeadSource = 'VSV2';
                    newOpp.HDI4I_Origen_de_la_oportunidad__c = 'VSV2';
                    newOpp.CurrencyIsoCode = 'CLF';  
                }
                 
                if (mapClientes.containsKey(item.rutDuenioVehiculo)) {
                    newOpp.AccountId = mapClientes.get(item.rutDuenioVehiculo).Id;
                    newOpp.BECS_Asegurado__c = mapClientes.get(item.rutDuenioVehiculo).Id;
                }

                if (mapClientes.containsKey(item.rutCliente)) {
                    newOpp.BECS_Contratante__c = mapClientes.get(item.rutCliente).Id;
                }

                if (mapCampanas.containsKey(item.campaniaCotizadorWeb)) {
                    newOpp.CampaignId = mapCampanas.get(item.campaniaCotizadorWeb).Id;
                    if (newOpp.CloseDate == null) {
                        newOpp.CloseDate = Date.today().addDays(integer.valueOf(mapCampanas.get(item.campaniaCotizadorWeb).BECS_DiasCierreOportunidad__c));
                    }
                }

                if (mapCuentaFinanciera.containsKey(item.numeroTarjeta)) {
                    newOpp.BECS_DatosBancarios__c = mapCuentaFinanciera.get(item.numeroTarjeta).Id;
                }else if (mapCuentaFinanciera.containsKey(item.numeroCuenta)) {
                    newOpp.BECS_DatosBancarios__c = mapCuentaFinanciera.get(item.numeroCuenta).Id;
                }

                /* if (mapCuentaFinanciera.containsKey(item.productoSeleccionado)) {
                    newOpp.FinServ__FinancialAccount__c = mapCuentaFinanciera.get(item.productoSeleccionado).Id;
                } */

                newOpp.HDI4I_Campana_cotizador_web__c = item.campaniaCotizadorWeb;
                newOpp.HDI4I_Dueno_vehiculo__c = item.duenioVehiculo;
                newOpp.HDI4I_Deducible__c = item.deducible;
                newOpp.HDI4I_Auto_reemplazo__c = item.autoReemplazo;
                newOpp.HDI4I_Producto_seleccionado__c = item.productoSeleccionado;
                newOpp.HDI4I_Tipo_de_vehiculo__c = item.tipoVehiculo;
                newOpp.HDI4I_Correo_asegurado__c = BECS_Util.validateEmail(item.emailCliente);
                newOpp.HDI4I_Marca__c = item.descripcionMarcaVehiculo;
                newOpp.HDI4I_Modelo__c = item.descripcionModeloVehiculo;
                newOpp.HDI4I_Digito_verificador_rut_cliente__c = item.digitoVerificadorRutCliente;
                newOpp.HDI4I_Digito_verif_rut_dueno_vehiculo__c = item.digitoVerificadorRutDuenioVeh;
                newOpp.HDI4I_Vehiculo_nuevo__c = item.esVehiculoNuevoOp;
                newOpp.HDI4I_Fecha_envio_cotizacion__c = item.fechaEnvioCotizacion;
                newOpp.HDI4I_Id_Oportunidad_web__c = item.idHdiOpWeb;
                newOpp.HDI4I_Oportunidad_gestionada__c = item.oportunidadGestionada;
                newOpp.HDI4I_Paso_cotizacion_web__c = item.pasoCotizacionWeb;
                newOpp.HDI4I_Patente_del_vehiculo__c = item.patenteVehiculo;
                newOpp.HDI4I_Prima_cotizo_seguro__c = item.primaCotizacionVehiculo;
                newOpp.HDI4I_RUT_del_cliente__c = item.rutCliente;
                newOpp.HDI4I_RUT_dueno_del_vehiculo__c = item.rutDuenioVehiculo;
                newOpp.HDI4I_Numero_contacto__c = item.telefonoCliente;
                newOpp.HDI4I_Vehiculo_tiene_patente__c = item.vehiculoTienePatenteOp;
                newOpp.HDI4I_Ano_del_vehiculo__c = item.anioVehiculo;
                newOpp.HDI4I_Responsabilidad_civil__c = item.resposabilidadCivilOp;
                newOpp.HDI4I_Id_Marca_vehiculo__c = item.idMarcaVehiculo;
                newOpp.HDI4I_Id_Modelo_vehiculo__c = item.idModeloVehiculo;
                newOpp.HDI4I_Tipo_de_pago__c = item.tipoDePagoOp;
                newOpp.HDI4I_Pago_primera_cuota__c = item.pagoPrimeraCuota;
                newOpp.HDI4I_Prioridad__c = item.prioridad;
                newOpp.LeadSource = item.origenProspectoOp;
                newOpp.HDI4I_IdTarifa__c = item.IdTarifa;
                newOpp.HDI4I_Codigo_de_producto_elegido__c = item.codigoProductoElegido;
                newOpp.HDI4I_Numero_chasis__c = item.chasis;
                newOpp.HDI4I_Numero_motor__c = item.numMotor;
                newOpp.HDI4I_Banco__c = item.banco;
                newOpp.HDI4I_Tipo_tarjeta__c = item.tipoTarjeta;
                newOpp.HDI4I_Numero_tarjeta__c = item.numeroTarjeta;
                newOpp.HDI4I_Sucursal__c = item.sucursal;
                newOpp.HDI4I_Numero_cuenta__c = item.numeroCuenta;
                newOpp.HDI4I_Numero_transaccion__c = item.numTransaccion;
                newOpp.HDI4I_Dia_cargo__c = item.diaCargo;
                newOpp.BECS_NumeroSimulacion__c = item.numeroSimulacion;
                newOpp.GCLID__c = item.GCLID;
                
                listOpportunities.add(newOpp);
            }
            system.debug(listOpportunities);

            Schema.SObjectField codigoUnico = Opportunity.Fields.HDI4I_Id_Oportunidad_web__c;
            Database.UpsertResult[] listInsertOpportunities = dataBase.upsert(listOpportunities, codigoUnico, true );

            list<ORG_IntegrationLogError__c> logError = new list<ORG_IntegrationLogError__c>();
            List<String> listErrores = new List<String>();
            List<String> listCodes = new List<String>();

            for (Database.UpsertResult sr : listInsertOpportunities) {
                if (!sr.isSuccess()) {
                    for(Database.Error err : sr.getErrors()) {
                        listErrores.add(err.getMessage());
                        //listCodes.add(String.valueOf(err.getStatusCode()));
                        listCodes.add(String.valueOf('201'));
                        system.debug(err.getMessage());
                    }
                }
            }

            // PARA LOS LOGS
            system.debug('setidHdiOpWeb: ' + setidHdiOpWeb);
            mappExistingOpps = new BECS_OpportunitySelector().selectByIdWeb(setidHdiOpWeb);
            system.debug('MAPPP' + mappExistingOpps);
            integer counter = 0;
            HDI_ApiSiniestroJSON api = new HDI_ApiSiniestroJSON();

            for(InParameters item : listParameters){
                resultado = new Result();
                if (mappExistingOpps.containsKey(item.idHdiOpWeb)){
                    resultado.idSalesforce = mappExistingOpps.get(item.idHdiOpWeb).id;
                    system.debug( 'LOG ITEM'+System.JSON.serialize(item));
                    system.debug('RESULT1'+mappExistingOpps.get(item.idHdiOpWeb).id);
                    resultado.mensaje = 'Success';
                    resultado.statusCode = '200';
                    logError.add(BECS_LogErrorTL.fullLog('Success', item, 'Correcto','',api));
                     
                }else if (!listCodes.isEmpty()) {
                    resultado.statusCode = listCodes[counter];
                    resultado.mensaje = listErrores[counter];
                    logError.add(BECS_LogErrorTL.fullLog('Error', item, 'No procesado', resultado.mensaje,api));   
                    counter++; 
                }
                listResultados.add(resultado);
                
            }
            new BECS_LogErrorTL(logError).insertLogs(logError);

        }catch (Exception e) {
            resultado.statusCode = '400';
            resultado.mensaje = e.getMessage() + ' Linea: ' + e.getLineNumber() + ' Trace: ' + e.getStackTraceString();
            listResultados.add(resultado);
            system.debug(e.getMessage());
        }
        System.debug(listResultados);
        return JSON.serialize(listResultados);
    }

    
    public class InParameters {
        public String nombreCliente;
        public String apellidoPaterno;
        public String campaniaCotizadorWeb;
        public String duenioVehiculo;
        public String deducible;
        public String autoReemplazo;
        public String productoSeleccionado;
        public String tipoVehiculo;
        public String emailCliente;
        public String descripcionMarcaVehiculo;
        public String descripcionModeloVehiculo;
        public String digitoVerificadorRutCliente;
        public String digitoVerificadorRutDuenioVeh;
        public String esVehiculoNuevoOp;
        public date fechaEnvioCotizacion;
        public String idHdiOpWeb;
        public String oportunidadGestionada;
        public String pasoCotizacionWeb;
        public String patenteVehiculo;
        public String primaCotizacionVehiculo;
        public String rutCliente;
        public String rutDuenioVehiculo;
        public String telefonoCliente;
        public String vehiculoTienePatenteOp;
        public String anioVehiculo;
        public String resposabilidadCivilOp;
        public String idMarcaVehiculo;
        public String idModeloVehiculo;
        public String tipoDePagoOp;
        public String pagoPrimeraCuota;
        public String prioridad;
        public String origenProspectoOp;
        public String IdTarifa;
        public String codigoProductoElegido;
        public String chasis;
        public String numMotor;
        public String banco;
        public String tipoTarjeta;
        public String numeroTarjeta;
        public String sucursal;
        public String numeroCuenta;
        public String numTransaccion;
        public String diaCargo;
        public String numeroSimulacion;
        public String GCLID;
    }

    public class Result{
        string idSalesforce;
        string statusCode;
        String mensaje;
    }
}