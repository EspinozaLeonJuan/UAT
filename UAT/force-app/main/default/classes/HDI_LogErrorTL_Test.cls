@isTest
public with sharing class HDI_LogErrorTL_Test {
    @TestSetup
    static void makeData(){
        Account acc = new Account(LastName = 'Test Company', Rut_sin_puntos_y_con_gui_n__pc = '15479853', PersonMobilePhone = '9908124632', 
        HDI4I_RUT_del_cliente__c = '15479853', CurrencyIsoCode = 'CLF', PersonEmail = 'test@gmail.com');
        insert acc;

        List<ORG_IntegrationLogError__c> errorLogList = new List<ORG_IntegrationLogError__c>();
        errorLogList.add(new ORG_IntegrationLogError__c(Name = 'WS_POST : Error', ORG_FechaHoraError__c = DateTime.now(), ORG_Proyecto__c = 'Instant Call',
        ORG_DescriptionError__c = 'Invalid format: "" at [line:17, column:34]', ORG_Estado__c = 'No procesado', ORG_Solicitud__c = getJsonError()));
        errorLogList.add(new ORG_IntegrationLogError__c(Name = 'WS_PUT : Error', ORG_FechaHoraError__c = DateTime.now(), ORG_Proyecto__c = 'Instant Call',
        ORG_DescriptionError__c = 'Invalid format: "" at [line:17, column:34]', ORG_Estado__c = 'No procesado', ORG_Solicitud__c = getJsonError()));
        errorLogList.add(new ORG_IntegrationLogError__c(Name = 'WS : Error', ORG_FechaHoraError__c = DateTime.now(), ORG_Proyecto__c = 'Instant Call',
        ORG_DescriptionError__c = 'Invalid format: "" at [line:17, column:34]', ORG_Estado__c = 'No procesado', ORG_Solicitud__c = getJsonError()));

        if(!errorLogList.isEmpty()){
            insert errorLogList;
        }

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
        
        Lead le1 = new Lead();
        le1.LastName = 'test';
        le1.LeadSource = 'VSV2';
        le1.Status = 'Nuevo';
        le1.HDI4I_Id_Oportunidad_web__c = '2022_15176715_CHERY_FULWIN_2019';
        insert le1;
    }

    @isTest
    static void retryApiHDINotFoundLead(){
        String searchWS = 'WS_POST%';
        Test.startTest();
        List<ORG_IntegrationLogError__c> logList = [SELECT Id, Name, ORG_Estado__c, ORG_Solicitud__c FROM ORG_IntegrationLogError__c 
                                                    WHERE ORG_Estado__c = 'No procesado' AND Name LIKE : searchWS LIMIT 1];
        
        if(!logList.isEmpty()){
            logList[0].ORG_Solicitud__c = getJsonSuccess1();
            logList[0].ORG_Estado__c = 'Pendiente';
            update logList;

            ORG_IntegrationLogError__c result = [SELECT Id, Name, ORG_Estado__c, ORG_Solicitud__c FROM ORG_IntegrationLogError__c WHERE Id =: logList[0].Id];

            System.assertEquals('Procesado', result.ORG_Estado__c);
        }
        Test.stopTest();
    }

    
    @isTest
    static void retryApiHDIFoundLead(){
        String searchWS = 'WS_POST%';
        Test.startTest();
        List<ORG_IntegrationLogError__c> logList = [SELECT Id, Name, ORG_Estado__c, ORG_Solicitud__c FROM ORG_IntegrationLogError__c 
                                                    WHERE ORG_Estado__c = 'No procesado' AND Name LIKE : searchWS LIMIT 1];
        if(!logList.isEmpty()){
            logList[0].ORG_Solicitud__c = getJsonSuccess2();
            logList[0].ORG_Estado__c = 'Pendiente';
            update logList;

            ORG_IntegrationLogError__c result = [SELECT Id, Name, ORG_Estado__c, ORG_Solicitud__c FROM ORG_IntegrationLogError__c WHERE Id =: logList[0].Id];

            System.assertEquals('Procesado', result.ORG_Estado__c);
        }
        Test.stopTest();
    }

    @isTest
    static void retryApiHDINotFoundAccount(){
        String searchWS = 'WS_POST%';
        Test.startTest();
        List<ORG_IntegrationLogError__c> logList = [SELECT Id, Name, ORG_Estado__c, ORG_Solicitud__c FROM ORG_IntegrationLogError__c 
                                                    WHERE ORG_Estado__c = 'No procesado' AND Name LIKE : searchWS LIMIT 1];
        if(!logList.isEmpty()){
            logList[0].ORG_Solicitud__c = getJsonSuccess3();
            logList[0].ORG_Estado__c = 'Pendiente';
            update logList;

            ORG_IntegrationLogError__c result = [SELECT Id, Name, ORG_Estado__c, ORG_Solicitud__c FROM ORG_IntegrationLogError__c WHERE Id =: logList[0].Id];

            System.assertEquals('Procesado', result.ORG_Estado__c);
        }
        Test.stopTest();
    }
    
    @isTest
    static void retryApiHDIFoundOpportunity(){
        String searchWS = 'WS_POST%';
        Test.startTest();
        List<ORG_IntegrationLogError__c> logList = [SELECT Id, Name,    ORG_Estado__c, ORG_Solicitud__c FROM ORG_IntegrationLogError__c 
                                                    WHERE ORG_Estado__c = 'No procesado' AND Name LIKE : searchWS LIMIT 1];
        List<lead> propsList = [SELECT Id FROM Lead WHERE HDI4I_Id_Oportunidad_web__c = '2022_15176715_CHERY_FULWIN_2017'];
        delete propsList;
                                            
        if(!logList.isEmpty()){
            logList[0].ORG_Solicitud__c = getJsonSuccess8();
            logList[0].ORG_Estado__c = 'Pendiente';
            update logList;

            ORG_IntegrationLogError__c result = [SELECT Id, Name, ORG_Estado__c, ORG_DescriptionError__c FROM ORG_IntegrationLogError__c WHERE Id =: logList[0].Id];
            System.assertEquals('Procesado', result.ORG_Estado__c);
        }
        Test.stopTest();
    }

    @isTest
    static void retryApiHDIUpdate(){
        Test.startTest();
        Map<String, ORG_IntegrationLogError__c> logMap = new Map<String, ORG_IntegrationLogError__c>();
        List<ORG_IntegrationLogError__c> logList = [SELECT Id, Name, ORG_Estado__c, ORG_Solicitud__c FROM ORG_IntegrationLogError__c 
                                                    WHERE ORG_Estado__c = 'No procesado'];
        if(!logList.isEmpty()){
            for(ORG_IntegrationLogError__c item : logList){
                logMap.put(item.Name.contains('WS_POST') ? 'WS_POST' : (item.Name.contains('WS_PUT') ? 'WS_PUT' : 'WS'), item);
            }
            
            if(logMap.containsKey('WS_POST')){
                ORG_IntegrationLogError__c errorPost = logMap.get('WS_POST');
                errorPost.ORG_Solicitud__c = getJsonSuccess3();
                errorPost.ORG_Estado__c = 'Pendiente';
                update errorPost;
                ORG_IntegrationLogError__c resultPost = [SELECT Id, Name, ORG_Estado__c, ORG_Solicitud__c FROM ORG_IntegrationLogError__c WHERE Id =: errorPost.Id];
                System.assertEquals('Procesado', resultPost.ORG_Estado__c);
                
                if(logMap.containsKey('WS_PUT')){
                	ORG_IntegrationLogError__c errorPut = logMap.get('WS_PUT');
                    errorPut.ORG_Solicitud__c = getJsonSuccess4();
                    errorPut.ORG_Estado__c = 'Pendiente';
                    update errorPut;
                    
                    ORG_IntegrationLogError__c resultPut = [SELECT Id, Name, ORG_Estado__c, ORG_Solicitud__c FROM ORG_IntegrationLogError__c WHERE Id =: errorPut.Id];
                    System.assertEquals('Procesado', resultPut.ORG_Estado__c);
            	}	
            } 
            
            if(logMap.containsKey('WS')){
                ORG_IntegrationLogError__c errorWS = logMap.get('WS');
                errorWS.ORG_Solicitud__c = getJsonSuccess3();
                errorWS.ORG_Estado__c = 'Pendiente';
                update errorWS;
                ORG_IntegrationLogError__c resultWS = [SELECT Id, Name, ORG_Estado__c, ORG_Solicitud__c FROM ORG_IntegrationLogError__c WHERE Id =: errorWS.Id];
                System.assertEquals('No procesado', resultWS.ORG_Estado__c);
            }
            
        }
        Test.stopTest();
    }
    
    @isTest
    static void retryApiHDINotOpportunity(){
        String searchWS = 'WS_PUT%';
        Test.startTest();
        List<ORG_IntegrationLogError__c> logList = [SELECT Id, Name, ORG_Estado__c, ORG_Solicitud__c FROM ORG_IntegrationLogError__c 
                                                    WHERE ORG_Estado__c = 'No procesado' AND Name LIKE : searchWS LIMIT 1];
        if(!logList.isEmpty()){
            logList[0].ORG_Solicitud__c = getJsonSuccess5();
            logList[0].ORG_Estado__c = 'Pendiente';
            update logList;

            ORG_IntegrationLogError__c result = [SELECT Id, Name, ORG_Estado__c, ORG_Solicitud__c FROM ORG_IntegrationLogError__c WHERE Id =: logList[0].Id];

            System.assertEquals('Procesado', result.ORG_Estado__c);
        }
        Test.stopTest();
    }

    @isTest
    static void retryApiHDIFoundAccount(){
        String searchWS = 'WS_PUT%';
        Test.startTest();
        List<ORG_IntegrationLogError__c> logList = [SELECT Id, Name, ORG_Estado__c, ORG_Solicitud__c FROM ORG_IntegrationLogError__c 
                                                    WHERE ORG_Estado__c = 'No procesado' AND Name LIKE : searchWS LIMIT 1];
        List<Lead> leadList = [SELECT Id FROM Lead WHERE HDI4I_Id_Oportunidad_web__c = '2022_15176715_CHERY_FULWIN_2019' LIMIT 1];
        delete leadList;


        if(!logList.isEmpty()){
            logList[0].ORG_Solicitud__c = getJsonSuccess9();
            logList[0].ORG_Estado__c = 'Pendiente';
            update logList;

            ORG_IntegrationLogError__c result = [SELECT Id, Name, ORG_Estado__c, ORG_Solicitud__c FROM ORG_IntegrationLogError__c WHERE Id =: logList[0].Id];

            System.assertEquals('Procesado', result.ORG_Estado__c);
        }
        Test.stopTest();
    }
    
    @isTest
    static void retryApiHDINotLead(){
        String searchWS = 'WS_PUT%';
        Test.startTest();
        List<ORG_IntegrationLogError__c> logList = [SELECT Id, Name, ORG_Estado__c, ORG_Solicitud__c FROM ORG_IntegrationLogError__c 
                                                    WHERE ORG_Estado__c = 'No procesado' AND Name LIKE : searchWS LIMIT 1];
        if(!logList.isEmpty()){
            logList[0].ORG_Solicitud__c = getJsonSuccess6();
            logList[0].ORG_Estado__c = 'Pendiente';
            update logList;

            ORG_IntegrationLogError__c result = [SELECT Id, Name, ORG_Estado__c, ORG_Solicitud__c FROM ORG_IntegrationLogError__c WHERE Id =: logList[0].Id];

            System.assertEquals('Procesado', result.ORG_Estado__c);
        }
        Test.stopTest();
    }
    
    @isTest
    static void retryApiHDICreateLead(){
        String searchWS = 'WS_PUT%';
        Test.startTest();
        List<ORG_IntegrationLogError__c> logList = [SELECT Id, Name, ORG_Estado__c, ORG_Solicitud__c FROM ORG_IntegrationLogError__c 
                                                    WHERE ORG_Estado__c = 'No procesado' AND Name LIKE : searchWS LIMIT 1];
        if(!logList.isEmpty()){
            logList[0].ORG_Solicitud__c = getJsonSuccess7();
            logList[0].ORG_Estado__c = 'Pendiente';
            update logList;

            ORG_IntegrationLogError__c result = [SELECT Id, Name, ORG_Estado__c, ORG_Solicitud__c FROM ORG_IntegrationLogError__c WHERE Id =: logList[0].Id];

            System.assertEquals('Procesado', result.ORG_Estado__c);
        }
        Test.stopTest();
    }
    
    @isTest
    static void retryApiHDIUpdateError(){
        String searchWS = 'WS_PUT%';
        Test.startTest();
        List<ORG_IntegrationLogError__c> logList = [SELECT Id, Name, ORG_Estado__c, ORG_Solicitud__c FROM ORG_IntegrationLogError__c 
                                                    WHERE ORG_Estado__c = 'No procesado' AND Name LIKE : searchWS LIMIT 1];
        if(!logList.isEmpty()){
            logList[0].ORG_Solicitud__c = getJsonError();
            logList[0].ORG_Estado__c = 'Pendiente';
            update logList;

            ORG_IntegrationLogError__c result = [SELECT Id, Name, ORG_Estado__c, ORG_Solicitud__c FROM ORG_IntegrationLogError__c WHERE Id =: logList[0].Id];

            System.assertEquals('No procesado', result.ORG_Estado__c);
        }
        Test.stopTest();
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
        result += '"vehiculoTienePatenteOp": "","anioVehiculo": "","resposabilidadCivilOp": "709460000","idMarcaVehiculo": "","idModeloVehiculo": "","tipoDePagoOp": "709460002","pagoPrimeraCuota": "709460000",';
        result += '"prioridad": "","origenProspectoOp": "752230001","UTMGoogle": "","IdTarifa": "","codigoProductoElegido": "","chasis": "","numMotor": "","banco": "","tipoTarjeta": "","numeroTarjeta": "","sucursal": "",';
        result += '"numeroCuenta": "","numTransaccion": "","diaCargo": "","tipoEnvio": ""}';
        return result;
    }
    
    private static String getJsonSuccess5(){
        String result = '';
        result += '{"idCuenta": "0016s00000SBc1fAAD","nombreCliente": "Test v1","apellidoPaterno": "Last name","campaniaCotizadorWeb": "Test campaniaCotizadorWeb","duenioVehiculo": "No","deducible": "709460000",';
        result += '"autoReemplazo": "709460000","productoSeleccionado": "709460000","tipoVehiculo": "709460000","emailCliente": "","direccionCliente": "","descripcionMarcaVehiculo": "","descripcionModeloVehiculo": "",';
        result += '"digitoVerificadorRutCliente": "","digitoVerificadorRutDuenioVeh": "","esVehiculoNuevoOp": "709460000","fechaEnvioCotizacion": "2021-01-30","idHdiOpWeb": "2022_15176715_CHERY_FULWIN_2019",';
        result += '"oportunidadGestionada": "","pasoCotizacionWeb": "12","patenteVehiculo": "","primaCotizacionVehiculo": "","rutCliente": "12345678","rutDuenioVehiculo": "15479853","telefonoCliente": "",';
        result += '"vehiculoTienePatenteOp": "","anioVehiculo": "","resposabilidadCivilOp": "709460000","idMarcaVehiculo": "","idModeloVehiculo": "","tipoDePagoOp": "709460002","pagoPrimeraCuota": "709460000",';
        result += '"prioridad": "","origenProspectoOp": "752230001","UTMGoogle": "","IdTarifa": "","codigoProductoElegido": "","chasis": "","numMotor": "","banco": "","tipoTarjeta": "","numeroTarjeta": "","sucursal": "",';
        result += '"numeroCuenta": "","numTransaccion": "","diaCargo": "","tipoEnvio": ""}';
        return result;
    }
    
    private static String getJsonSuccess6(){
        String result = '';
        result += '{"idCuenta": "0016s00000SBc1fAAD","nombreCliente": "Test v1","apellidoPaterno": "Last name","campaniaCotizadorWeb": "Test campaniaCotizadorWeb","duenioVehiculo": "No","deducible": "709460000",';
        result += '"autoReemplazo": "709460000","productoSeleccionado": "709460000","tipoVehiculo": "709460000","emailCliente": "","direccionCliente": "","descripcionMarcaVehiculo": "","descripcionModeloVehiculo": "",';
        result += '"digitoVerificadorRutCliente": "","digitoVerificadorRutDuenioVeh": "","esVehiculoNuevoOp": "709460000","fechaEnvioCotizacion": "2021-01-30","idHdiOpWeb": "2022_15176715_CHERY_FULWIN_2020",';
        result += '"oportunidadGestionada": "","pasoCotizacionWeb": "12","patenteVehiculo": "","primaCotizacionVehiculo": "","rutCliente": "12345678","rutDuenioVehiculo": "15479853","telefonoCliente": "",';
        result += '"vehiculoTienePatenteOp": "","anioVehiculo": "","resposabilidadCivilOp": "709460000","idMarcaVehiculo": "","idModeloVehiculo": "","tipoDePagoOp": "709460002","pagoPrimeraCuota": "709460000",';
        result += '"prioridad": "","origenProspectoOp": "752230001","UTMGoogle": "","IdTarifa": "","codigoProductoElegido": "","chasis": "","numMotor": "","banco": "","tipoTarjeta": "","numeroTarjeta": "","sucursal": "",';
        result += '"numeroCuenta": "","numTransaccion": "","diaCargo": "","tipoEnvio": ""}';
        return result;
    }
    
    private static String getJsonSuccess7(){
        String result = '';
        result += '{"idCuenta": "0016s00000SBc1fAAD","nombreCliente": "Test v1","apellidoPaterno": "Last name","campaniaCotizadorWeb": "Test campaniaCotizadorWeb","duenioVehiculo": "No","deducible": "709460000",';
        result += '"autoReemplazo": "709460000","productoSeleccionado": "709460000","tipoVehiculo": "709460000","emailCliente": "","direccionCliente": "","descripcionMarcaVehiculo": "","descripcionModeloVehiculo": "",';
        result += '"digitoVerificadorRutCliente": "","digitoVerificadorRutDuenioVeh": "","esVehiculoNuevoOp": "709460000","fechaEnvioCotizacion": "2021-01-30","idHdiOpWeb": "2022_15176715_CHERY_FULWIN_2020",';
        result += '"oportunidadGestionada": "","pasoCotizacionWeb": "1000","patenteVehiculo": "","primaCotizacionVehiculo": "","rutCliente": "12345678","rutDuenioVehiculo": "15479853","telefonoCliente": "",';
        result += '"vehiculoTienePatenteOp": "","anioVehiculo": "","resposabilidadCivilOp": "709460000","idMarcaVehiculo": "","idModeloVehiculo": "","tipoDePagoOp": "709460002","pagoPrimeraCuota": "709460000",';
        result += '"prioridad": "","origenProspectoOp": "752230001","UTMGoogle": "","IdTarifa": "","codigoProductoElegido": "","chasis": "","numMotor": "","banco": "","tipoTarjeta": "","numeroTarjeta": "","sucursal": "",';
        result += '"numeroCuenta": "","numTransaccion": "","diaCargo": "","tipoEnvio": ""}';
        return result;
    }

    private static String getJsonSuccess8(){
        String result = '';
        result += '{"idCuenta": "0016s00000SBc1fAAD","nombreCliente": "Test v1","apellidoPaterno": "Last name","campaniaCotizadorWeb": "Test campaniaCotizadorWeb","duenioVehiculo": "No","deducible": "709460000",';
        result += '"autoReemplazo": "709460000","productoSeleccionado": "709460000","tipoVehiculo": "709460000","emailCliente": "","direccionCliente": "","descripcionMarcaVehiculo": "","descripcionModeloVehiculo": "",';
        result += '"digitoVerificadorRutCliente": "","digitoVerificadorRutDuenioVeh": "","esVehiculoNuevoOp": "709460000","fechaEnvioCotizacion": "2021-01-30","idHdiOpWeb": "2022_15176715_CHERY_FULWIN_2017",';
        result += '"oportunidadGestionada": "","pasoCotizacionWeb": "12","patenteVehiculo": "","primaCotizacionVehiculo": "","rutCliente": "15479853","rutDuenioVehiculo": "15479853","telefonoCliente": "",';
        result += '"vehiculoTienePatenteOp": "","anioVehiculo": "","resposabilidadCivilOp": "709460000","idMarcaVehiculo": "","idModeloVehiculo": "","tipoDePagoOp": "709460000","pagoPrimeraCuota": "709460000",';
        result += '"prioridad": "","origenProspectoOp": "752230001","UTMGoogle": "","IdTarifa": "","codigoProductoElegido": "","chasis": "","numMotor": "","banco": "","tipoTarjeta": "","numeroTarjeta": "","sucursal": "",';
        result += '"numeroCuenta": "","numTransaccion": "","diaCargo": "","tipoEnvio": ""}';
        return result;
    }

    private static String getJsonSuccess9(){
        String result = '';
        result += '{"idCuenta": "0016s00000SBc1fAAD","nombreCliente": "Test v1","apellidoPaterno": "Last name","campaniaCotizadorWeb": "Test campaniaCotizadorWeb","duenioVehiculo": "No","deducible": "709460000",';
        result += '"autoReemplazo": "709460000","productoSeleccionado": "709460000","tipoVehiculo": "709460000","emailCliente": "","direccionCliente": "","descripcionMarcaVehiculo": "","descripcionModeloVehiculo": "",';
        result += '"digitoVerificadorRutCliente": "","digitoVerificadorRutDuenioVeh": "","esVehiculoNuevoOp": "709460000","fechaEnvioCotizacion": "2021-01-30","idHdiOpWeb": "2022_15176715_CHERY_FULWIN_2019",';
        result += '"oportunidadGestionada": "","pasoCotizacionWeb": "12","patenteVehiculo": "","primaCotizacionVehiculo": "","rutCliente": "15479853","rutDuenioVehiculo": "15479853","telefonoCliente": "",';
        result += '"vehiculoTienePatenteOp": "","anioVehiculo": "","resposabilidadCivilOp": "709460000","idMarcaVehiculo": "","idModeloVehiculo": "","tipoDePagoOp": "709460002","pagoPrimeraCuota": "709460000",';
        result += '"prioridad": "","origenProspectoOp": "752230001","UTMGoogle": "","IdTarifa": "","codigoProductoElegido": "","chasis": "","numMotor": "","banco": "","tipoTarjeta": "","numeroTarjeta": "","sucursal": "",';
        result += '"numeroCuenta": "","numTransaccion": "","diaCargo": "","tipoEnvio": ""}';
        return result;
    }
}