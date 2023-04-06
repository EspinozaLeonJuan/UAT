public with sharing class HDI_LogErrorTL {
    
    public static void retryCreateOpportunity(List<ORG_IntegrationLogError__c> newList) {    
        //List<User> userList = [SELECT Id FROM User WHERE IntegradorInstantCall__c = TRUE LIMIT 1];

        for(ORG_IntegrationLogError__c newItem : newList) {
            if(newItem.ORG_Estado__c == 'Pendiente' && newItem.ORG_Proyecto__c == 'Instant Call') {
                /*if(userList.isEmpty()) {
                    newItem.ORG_Estado__c = 'No procesado';
                    newItem.ORG_DescriptionError__c = 'No se puede generar el reintento debido a que no existe el usuario Consultor HDI.';
                    continue;
                }
                
                if(newItem.Name != null && newItem.Name != '' && newItem.Name.contains('WS_POST')){
                    createApiHDI(newItem, userList[0].Id);
                } else if(newItem.Name != null && newItem.Name != '' && newItem.Name.contains('WS_PUT')){
                    updateAPIHDI(newItem, userList[0].Id);
                } else {
                    newItem.ORG_Estado__c = 'No procesado';
                    newItem.ORG_DescriptionError__c = 'No se definió el tipo de servicio realizado (POST/PUT).';
                } */
                reintentaUpsert(newItem.ORG_Solicitud__c);
                newItem.ORG_Estado__c = 'Procesado';
            }
        }   
    }

    @future
    public static void reintentaUpsert(String jsonToTest){
        BECS_OpportunityAPI.InParameters parameters = (BECS_OpportunityAPI.InParameters) System.JSON.deserialize(jsonToTest, BECS_OpportunityAPI.InParameters.class);
        List<BECS_OpportunityAPI.InParameters> listParameters = new List<BECS_OpportunityAPI.InParameters>();
        listParameters.add(parameters);

        String myJSON = JSON.serialize(listParameters);
        System.debug(myJSON);
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/v2/opportunity';
        request.httpMethod = 'POST';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf(myJSON);
        RestContext.request = request;
    }

    /* private static void updateAPIHDI(ORG_IntegrationLogError__c newItem, String ownerId) {
        string respuesta = '';
        try{
            CreateAPI createApi = (CreateAPI) JSON.deserialize(newItem.ORG_Solicitud__c, CreateAPI.class);   
            
            integer tiempoCrono = 0;
            string cr = '';
            string ag = '';
            Lead prospecto;
            Opportunity oportunidad;
            string mensaje = '';
            string id_web = '';
            string paso = '';
            string correo = '';
            tiempoCrono = 10;
            
            boolean ActivarCrono = false;
            
            prospecto = ApiHDI.ConstructorLead(createApi);
            
            if(prospecto.HDI4I_Paso_cotizacion_web__c == 'Contratar' || prospecto.HDI4I_Paso_cotizacion_web__c == 'Éxito'){
                oportunidad = ApiHDI.ConstructorOppo(createApi);
                
                if(oportunidad.HDI4I_Banco__c  == '1'){
                    oportunidad.HDI4I_Banco__c = 'BANCO BICE';
                } else if(oportunidad.HDI4I_Banco__c  == '2'){
                    oportunidad.HDI4I_Banco__c = 'BANCO CHILE';
                } else if(oportunidad.HDI4I_Banco__c  == '3'){
                    oportunidad.HDI4I_Banco__c = 'BANCO ESTADO';
                } else if(oportunidad.HDI4I_Banco__c  == '6'){
                    oportunidad.HDI4I_Banco__c = 'BANCO BCI';
                } else if(oportunidad.HDI4I_Banco__c  == '8'){
                    oportunidad.HDI4I_Banco__c = 'CITIBANK';
                } else if(oportunidad.HDI4I_Banco__c  == '9'){
                    oportunidad.HDI4I_Banco__c = 'CORPBANCA';
                } else if(oportunidad.HDI4I_Banco__c  == '10'){
                    oportunidad.HDI4I_Banco__c = 'BANCO DEL DESARROLLO';
                } else if(oportunidad.HDI4I_Banco__c  == '11'){
                    oportunidad.HDI4I_Banco__c = 'BANCO SANTANDER SANTIAGO';
                } else if(oportunidad.HDI4I_Banco__c  == '12'){
                    oportunidad.HDI4I_Banco__c = 'BANCO SUDAMERICANO';
                } else if(oportunidad.HDI4I_Banco__c  == '13'){
                    oportunidad.HDI4I_Banco__c = 'SECURITY PACIFIC';
                } else if(oportunidad.HDI4I_Banco__c  == '14'){
                    oportunidad.HDI4I_Banco__c = 'BANCO BBVA';
                } else if(oportunidad.HDI4I_Banco__c  == '28'){
                    oportunidad.HDI4I_Banco__c = 'SCOTIABANK';
                } else if(oportunidad.HDI4I_Banco__c  == '30'){
                    oportunidad.HDI4I_Banco__c = 'BANCO ITAU';
                } else if(oportunidad.HDI4I_Banco__c  == '31'){
                    oportunidad.HDI4I_Banco__c = 'BANCO FALABELLA';
                } else if(oportunidad.HDI4I_Banco__c  == '99'){
                    oportunidad.HDI4I_Banco__c = 'SIN BANCO';
                } else{
                    oportunidad.HDI4I_Banco__c = 'BANCO DESCONOCIDO';
                }
                system.debug(oportunidad.HDI4I_Banco__c);
            }
            
            //Verifica si el id de la oportunidad existe en una oportunidad ya creada. de ser true, actualiza los datos de esa oportunidad.
            if(ApiHDI.existeOportunidad(prospecto.HDI4I_Id_Oportunidad_web__c)== true){
                
                Opportunity opo = new Opportunity();
                
                opo = ApiHDI.llamarOppo(prospecto.HDI4I_Id_Oportunidad_web__c);
                
                opo.HDI4I_Deducible__c = prospecto.HDI4I_Deducible__c;
                opo.HDI4I_Auto_reemplazo__c = prospecto.HDI4I_Auto_reemplazo__c;
                opo.HDI4I_Responsabilidad_civil__c = prospecto.HDI4I_Responsabilidad_civil__c;
                opo.HDI4I_Codigo_de_producto_elegido__c = prospecto.HDI4I_Codigo_de_producto_elegido__c;
                opo.LeadSource = prospecto.LeadSource;
                opo.HDI4I_Paso_cotizacion_web__c = prospecto.HDI4I_Paso_cotizacion_web__c;
                opo.HDI4I_Vehiculo_nuevo__c = prospecto.HDI4I_Vehiculo_nuevo__c;
                opo.HDI4I_Codigo_de_producto_elegido__c = prospecto.HDI4I_Codigo_de_producto_elegido__c;
                opo.HDI4I_Prioridad__c = prospecto.HDI4I_Prioridad__c;
                opo.HDI4I_Tipo_de_pago__c = prospecto.HDI4I_Tipo_de_pago__c;
                opo.HDI4I_Patente_del_vehiculo__c = prospecto.HDI4I_Patente_del_vehiculo__c;
                opo.HDI4I_Hora__c = prospecto.HDI4I_Hora__c;
                opo.HDI4I_Minuto__c = prospecto.HDI4I_Minuto__c;
                opo.HDI4I_Hora_cronometro__c = prospecto.HDI4I_Hora_cronometro__c;
                opo.BECS_NumeroSimulacion__c = prospecto.BECS_NumeroSimulacion__c;
                opo.HDI4I_Campana_cotizador_web__c = prospecto.HDI4I_Campana_cotizador_web__c;
                //Se verifica el paso de cotización web. Actuaiza los últimos datos de los pasos al momento de pagar.
                if(prospecto.HDI4I_Paso_cotizacion_web__c == 'Contratar' || prospecto.HDI4I_Paso_cotizacion_web__c == 'Éxito'){
                    if(opo.HDI4I_Dueno_vehiculo__c == 'Sí'){
                        
                    }
                    opo.HDI4I_Nombres_asegurado__c = prospecto.FirstName;
                    opo.HDI4I_Apellido_paterno_asegurado__c  = prospecto.LastName;
                    opo.HDI4I_Numero_chasis__c = oportunidad.HDI4I_Numero_chasis__c;
                    opo.HDI4I_Numero_motor__c = oportunidad.HDI4I_Numero_motor__c;
                    opo.HDI4I_Banco__c = oportunidad.HDI4I_Banco__c;
                    opo.HDI4I_Tipo_tarjeta__c = oportunidad.HDI4I_Tipo_tarjeta__c;
                    opo.HDI4I_Numero_tarjeta__c = oportunidad.HDI4I_Numero_tarjeta__c;
                    opo.HDI4I_Numero_cuenta__c = oportunidad.HDI4I_Numero_cuenta__c;
                    opo.HDI4I_Dia_cargo__c = oportunidad.HDI4I_Dia_cargo__c;
                    opo.HDI4I_Sucursal__c = oportunidad.HDI4I_Sucursal__c;
                    opo.HDI4I_Numero_transaccion__c = oportunidad.HDI4I_Numero_transaccion__c;            
                    
                }            
                
                try{                
                    update opo;
                    
                    if(prospecto.HDI4I_Paso_cotizacion_web__c == 'Contratar'){
                        mensaje = ' Oportunidad actualizada con PUT '+opo.HDI4I_Paso_cotizacion_web__c;
                        correo = 'Se actualizó la oportunidad: '+opo.HDI4I_Id_Oportunidad_web__c+' paso Contratar';
                        
                        ActivarCrono = true;
                    } else {
                        mensaje = ' Oportunidad actualizada con PUT '+opo.HDI4I_Paso_cotizacion_web__c;
                        correo = 'Se actualizó la oportunidad: '+opo.HDI4I_Id_Oportunidad_web__c+' paso '+opo.HDI4I_Paso_cotizacion_web__c;
                        ActivarCrono = true;
                    }
                    newItem.ORG_Estado__c = 'Procesado';
                }catch(DmlException e){
                    newItem.ORG_Estado__c = 'No procesado';
                    newItem.ORG_DescriptionError__c = e.getMessage();
                }
            } else if(ApiHDI.existeOportunidad(prospecto.HDI4I_Id_Oportunidad_web__c)== false){//Cuando es false, se asimila que se va a actualizar un prospecto con el paso elejir y así convertir en una oportunidad.            
                
                //SE comprueba si efectivamente el prospecto existe para poder actualizar su paso de cotización
                if(ApiHDI.prospectoExiste(prospecto.HDI4I_Id_Oportunidad_web__c)== true){                
                    
                    Lead pro = new Lead();
                    pro = ApiHDI.llamarLead(prospecto.HDI4I_Id_Oportunidad_web__c);
                    //system.debug(pro);
                    //----------------------------------------------------------------------------------------------------------------------VERIFICAR QUE EL RUT EXISTE EN UNA CUENTA ANTES DE TRANSFORMAR EM OPORTUNIDAD
                    if(ApiHDI.cuentaYaCreada(prospecto.HDI4I_RUT_del_cliente__c)== true){
                        
                    } else {                    
                        
                        pro.FirstName = prospecto.FirstName;
                        pro.LastName = prospecto.LastName;
                        pro.HDI4I_Deducible__c = prospecto.HDI4I_Deducible__c;
                        pro.HDI4I_Auto_reemplazo__c = prospecto.HDI4I_Auto_reemplazo__c;
                        pro.HDI4I_Responsabilidad_civil__c = prospecto.HDI4I_Responsabilidad_civil__c;
                        pro.LeadSource = prospecto.LeadSource;
                        pro.HDI4I_Paso_cotizacion_web__c = prospecto.HDI4I_Paso_cotizacion_web__c;
                        pro.HDI4I_Codigo_de_producto_elegido__c = prospecto.HDI4I_Codigo_de_producto_elegido__c;
                        pro.HDI4I_Prioridad__c = prospecto.HDI4I_Prioridad__c;
                        pro.HDI4I_Tipo_de_pago__c = prospecto.HDI4I_Tipo_de_pago__c;
                        pro.HDI4I_Patente_del_vehiculo__c = prospecto.HDI4I_Patente_del_vehiculo__c;
                        pro.HDI4I_Hora__c = prospecto.HDI4I_Hora__c;
                        pro.HDI4I_Minuto__c = prospecto.HDI4I_Minuto__c;
                        pro.HDI4I_Vehiculo_nuevo__c = prospecto.HDI4I_Vehiculo_nuevo__c;
                        pro.HDI4I_Hora_cronometro__c = prospecto.HDI4I_Hora_cronometro__c;                    
                        pro.HDI4I_Campana_cotizador_web__c = prospecto.HDI4I_Campana_cotizador_web__c;
                        try{
                            update pro;

                            if(pro.HDI4I_Paso_cotizacion_web__c == 'Elegir'){
                                mensaje = ' actualizado con PUT a paso Elegir';
                                correo = 'Se actualiza prospecto '+prospecto.HDI4I_Id_Oportunidad_web__c+ 'a paso Elegir';
                                ActivarCrono = true;
                            } else {
                                mensaje = ' actualizado con PUT con paso '+prospecto.HDI4I_Paso_cotizacion_web__c;
                                correo = 'Se actualiza prospecto '+prospecto.HDI4I_Id_Oportunidad_web__c+ 'a paso '+prospecto.HDI4I_Paso_cotizacion_web__c;
                                ActivarCrono = true;
                            }
                            newItem.ORG_Estado__c = 'Procesado';
                        }catch(DmlException e){
                            newItem.ORG_Estado__c = 'No procesado';
                            newItem.ORG_DescriptionError__c = e.getMessage();
                        }
                        
                    }
                } else if(ApiHDI.prospectoExiste(prospecto.HDI4I_Id_Oportunidad_web__c) == false){//Desde aquí se crea un Lead nuevo en casos especiales 
                    // /* Valida si existe cuenta antes de crear prospecto - Error 08/02/2022 
                    if(ApiHDI.cuentaYaCreada(prospecto.HDI4I_RUT_del_cliente__c)== true){
                        Opportunity opor = new Opportunity();                   
                        List<Account> cuenta;
                        cuenta = [select id, PersonMobilePhone, HDI4I_RUT_del_cliente__c, HDI4I_Digito_verificador_rut_cliente__c, HDI4I_UTMGoogle__c from Account where HDI4I_RUT_del_cliente__c =: prospecto.HDI4I_RUT_del_cliente__c];
                        if(prospecto.HDI4I_Paso_cotizacion_web__c == '1000'){
                            prospecto.HDI4I_Paso_cotizacion_web__c = 'Elegir';
                        }
                        opor.AccountId = cuenta[0].id;
                        opor.Name = prospecto.HDI4I_Id_Oportunidad_web__c;
                        opor.HDI4I_Paso_cotizacion_web__c = prospecto.HDI4I_Paso_cotizacion_web__c;
                        opor.HDI4I_Prioridad__c = prospecto.HDI4I_Prioridad__c;
                        opor.HDI4I_Numero_contacto__c = cuenta[0].PersonMobilePhone;
                        opor.HDI4I_RUT_del_cliente__c = cuenta[0].HDI4I_RUT_del_cliente__c;
                        opor.HDI4I_Auto_reemplazo__c = prospecto.HDI4I_Auto_reemplazo__c;
                        opor.HDI4I_Ano_del_vehiculo__c = prospecto.HDI4I_Ano_del_vehiculo__c;
                        opor.HDI4I_Campana_cotizador_web__c = prospecto.HDI4I_Campana_cotizador_web__c;
                        opor.HDI4I_Codigo_de_producto_elegido__c = prospecto.HDI4I_Codigo_de_producto_elegido__c;
                        opor.HDI4I_Deducible__c = prospecto.HDI4I_Deducible__c;
                        opor.HDI4I_Digito_verificador_rut_cliente__c = cuenta[0].HDI4I_Digito_verificador_rut_cliente__c;
                        opor.HDI4I_Digito_verif_rut_dueno_vehiculo__c = prospecto.HDI4I_Digito_verif_rut_dueno_vehiculo__c;
                        opor.HDI4I_Fecha_envio_cotizacion__c = prospecto.HDI4I_Fecha_envio_cotizacion__c;
                        opor.HDI4I_Id_Marca_vehiculo__c = prospecto.HDI4I_Id_Marca_vehiculo__c;
                        opor.HDI4I_Id_Modelo_vehiculo__c = prospecto.HDI4I_Id_Modelo_vehiculo__c;
                        opor.HDI4I_IdTarifa__c = prospecto.HDI4I_IdTarifa__c;
                        opor.HDI4I_Marca__c = prospecto.HDI4I_Marca__c;
                        opor.HDI4I_Modelo__c = prospecto.HDI4I_Modelo__c;
                        opor.HDI4I_Pago_primera_cuota__c = prospecto.HDI4I_Pago_primera_cuota__c;
                        opor.HDI4I_Patente_del_vehiculo__c = prospecto.HDI4I_Patente_del_vehiculo__c;
                        opor.HDI4I_Prima_cotizo_seguro__c = prospecto.HDI4I_Prima_cotizo_seguro__c;
                        opor.HDI4I_Producto_seleccionado__c = prospecto.HDI4I_Producto_seleccionado__c;
                        opor.HDI4I_Responsabilidad_civil__c = prospecto.HDI4I_Responsabilidad_civil__c;
                        opor.HDI4I_RUT_dueno_del_vehiculo__c = prospecto.HDI4I_RUT_dueno_del_vehiculo__c;//verificar despues este campo para comprobar si cliente y pagador son los mismos
                        opor.HDI4I_Tipo_de_pago__c = prospecto.HDI4I_Tipo_de_pago__c;
                        opor.HDI4I_Tipo_de_vehiculo__c = prospecto.HDI4I_Tipo_de_vehiculo__c;
                        opor.HDI4I_UTMGoogle__c = cuenta[0].HDI4I_UTMGoogle__c;
                        opor.HDI4I_Dueno_vehiculo__c = prospecto.HDI4I_Dueno_vehiculo__c;
                        opor.HDI4I_Oportunidad_gestionada__c = prospecto.HDI4I_Oportunidad_gestionada__c;
                        opor.HDI4I_Vehiculo_nuevo__c = prospecto.HDI4I_Vehiculo_nuevo__c;
                        opor.HDI4I_Vehiculo_tiene_patente__c = prospecto.HDI4I_Vehiculo_tiene_patente__c;
                        opor.HDI4I_Id_Oportunidad_web__c = prospecto.HDI4I_Id_Oportunidad_web__c;
                        opor.HDI4I_Hora_cronometro__c = prospecto.HDI4I_Hora_cronometro__c;
                        opor.HDI4I_Oportunidad_asignada__c = false;
                        opor.StageName = 'Nuevo';
                        opor.CloseDate = ApiHDI.fechaCierre();
                        opor.LeadSource = 'VSV2';
                        opor.CurrencyIsoCode = 'CLF';
                        opor.BECS_NumeroSimulacion__c = prospecto.BECS_NumeroSimulacion__c;
                        opor.HDI4I_Campana_cotizador_web__c = prospecto.HDI4I_Campana_cotizador_web__c;
                        try{
                            opor.OwnerId = ownerId;
                            insert opor;
                            
                            if(opor.HDI4I_Paso_cotizacion_web__c.equals('Elegir')){
                                system.debug('Este es el id de la oportunidad asignada a una cuenta existente: '+opor.id);
                                mensaje = ' Se crea oportunidad manualmente con paso Elegir';
                                
                                correo = 'Se convierte prospecto '+prospecto.HDI4I_Id_Oportunidad_web__c+' con cuenta existente';
                                //system.debug(ApiHDI.existeOportunidad(opor.HDI4I_Id_Oportunidad_web__c));
                            }else {
                                mensaje = ' se crea oportunidad manualmente con paso '+opor.HDI4I_Paso_cotizacion_web__c;
                                correo = 'Se convierte prospecto '+prospecto.HDI4I_Id_Oportunidad_web__c+' con cuenta existente';
                                ActivarCrono = true;
                            }
                            newItem.ORG_Estado__c = 'Procesado';
                        }catch(DmlException e){
                            System.debug('Error: ' + e.getMessage());
                            newItem.ORG_Estado__c = 'No procesado';
                            newItem.ORG_DescriptionError__c = e.getMessage();
                        } 
                       
                    }
                    else {  // * FIN Valida si existe cuenta antes de crear prospecto - Error 08/02/2022 
                        if(prospecto.HDI4I_Paso_cotizacion_web__c == '1000'){
                            if(prospecto.HDI4I_Deducible__c == '' && prospecto.HDI4I_Auto_reemplazo__c == '' && prospecto.HDI4I_Responsabilidad_civil__c == ''){
                                prospecto.HDI4I_Paso_cotizacion_web__c = 'Cotizar';
                            } else{
                                prospecto.HDI4I_Paso_cotizacion_web__c = 'Elegir';
                            }
                        }
                        
                        try{
                            if((prospecto.HDI4I_Paso_cotizacion_web__c == 'Elegir' ||  prospecto.HDI4I_Paso_cotizacion_web__c == 'Cotizar') && (prospecto.HDI4I_Prioridad__c == '2' || prospecto.HDI4I_Prioridad__c == '100')){
                                insert prospecto;
                                
    
                                if(prospecto.HDI4I_Paso_cotizacion_web__c == 'Elegir'){
                                    ActivarCrono = true;
                                    mensaje = ' Se creó un prospecto con paso Elegir';
                                    correo = 'Se crea prospecto en PUT: '+prospecto.HDI4I_Id_Oportunidad_web__c+' con paso Elegir';
                                } else if(prospecto.HDI4I_Paso_cotizacion_web__c == 'Cotizar'){
                                    mensaje = ' Se creó un prospecto con paso Cotizar';
                                    correo = 'Se crea prospecto en PUT: '+prospecto.HDI4I_Id_Oportunidad_web__c+' con paso Cotizar';
                                    ActivarCrono = true;
                                }
                                system.debug(prospecto.id);
                                //update prospecto;
                            } else{
                                mensaje = ' ERROR: Sólo se puede crear un prospecto en paso Elegir y Prioridad 2';
                                correo = 'Error al crear un prospecto en PUT: '+prospecto.HDI4I_Id_Oportunidad_web__c;
                            }
                            
                            newItem.ORG_Estado__c = 'Procesado';
                        }catch(DmlException e){
                            System.debug('Error: ' + e.getMessage());
                            newItem.ORG_Estado__c = 'No procesado';
                            newItem.ORG_DescriptionError__c = e.getMessage();
                        } 
                    }
                    
                    
                } else {
                    mensaje = 'No se creó ningún dato';
                    correo = 'No se creó ni actualizó ningún dato';
                }         
                
            }
            
            if(mensaje == ' enviado a oportunidad con PUT' || mensaje == ' actualizado con PUT ok' || ActivarCrono == true){
                
                cr = ApiHDI.cronometro(prospecto.HDI4I_Id_Oportunidad_web__c, prospecto.HDI4I_Hora__c, prospecto.HDI4I_Minuto__c, tiempoCrono, prospecto.HDI4I_Hora_cronometro__c);
            }
            
            
            respuesta = mensaje +' '+ id_web+' '+cr+ag;
            system.debug(respuesta);   
        } catch(Exception ex){
            newItem.ORG_Estado__c = 'No procesado';
            newItem.ORG_DescriptionError__c = ex.getMessage();
        }
    }*/
    
    /*private static void createApiHDI(ORG_IntegrationLogError__c newItem, String ownerId) {
        String respuesta = '';
        try{
            Opportunity oportunidad; // Fix 31-01-2022
            boolean ActivarCrono = false;
            integer tiempoCrono = 0;
            tiempoCrono = 10;
            Lead prospecto;
            string mensaje = '';
            string cr = '';
            String correo = '';        
            
            CreateAPI createApi = (CreateAPI) JSON.deserialize(newItem.ORG_Solicitud__c, CreateAPI.class);                    
            
            prospecto = ApiHDI.ConstructorLead(createApi);
            
            system.debug(prospecto.LastName);        
            
            /*if(ApiHDI.prospectoExiste(prospecto.HDI4I_Id_Oportunidad_web__c)== true){
                List<Lead> pro;
                pro = [select id, FirstName, LastName, HDI4I_Deducible__c, HDI4I_Auto_reemplazo__c, HDI4I_Responsabilidad_civil__c, HDI4I_Id_Oportunidad_web__c, HDI4I_Hora_cronometro__c 
                    from lead where HDI4I_Id_Oportunidad_web__c =:prospecto.HDI4I_Id_Oportunidad_web__c];            
                
                pro[0].FirstName = prospecto.FirstName;
                pro[0].LastName = prospecto.LastName;
                pro[0].HDI4I_Deducible__c = prospecto.HDI4I_Deducible__c;
                pro[0].HDI4I_Auto_reemplazo__c = prospecto.HDI4I_Auto_reemplazo__c;
                pro[0].HDI4I_Responsabilidad_civil__c = prospecto.HDI4I_Responsabilidad_civil__c;
                pro[0].HDI4I_Hora_cronometro__c = prospecto.HDI4I_Hora_cronometro__c;
                pro[0].HDI4I_Campana_cotizador_web__c = prospecto.HDI4I_Campana_cotizador_web__c;
                try{
                    update pro[0];
                    mensaje = 'Actualizado con POST '+ pro[0].id + ' '+pro[0].HDI4I_Id_Oportunidad_web__c;
                    correo = 'Se ha actualizado con POST: '+pro[0].HDI4I_Id_Oportunidad_web__c;
                    ActivarCrono = true;
                    newItem.ORG_Estado__c = 'Procesado';
                }catch(DmlException e){
                    System.debug('Error actualizando datos de prospecto: ' + e.getMessage());
                    newItem.ORG_Estado__c = 'No procesado';
                    newItem.ORG_DescriptionError__c = e.getMessage();
                }            
                
            } else { //

                if(ApiHDI.prospectoExiste(prospecto.HDI4I_Id_Oportunidad_web__c)== true){
                    List<Lead> pro;
                    pro = [select id, FirstName, LastName, HDI4I_Deducible__c, HDI4I_Auto_reemplazo__c, HDI4I_Responsabilidad_civil__c, HDI4I_Id_Oportunidad_web__c, HDI4I_Hora_cronometro__c 
                        from lead where HDI4I_Id_Oportunidad_web__c =:prospecto.HDI4I_Id_Oportunidad_web__c];            
                    
                    pro[0].FirstName = prospecto.FirstName;
                    pro[0].LastName = prospecto.LastName;
                    pro[0].HDI4I_Deducible__c = prospecto.HDI4I_Deducible__c;
                    pro[0].HDI4I_Auto_reemplazo__c = prospecto.HDI4I_Auto_reemplazo__c;
                    pro[0].HDI4I_Responsabilidad_civil__c = prospecto.HDI4I_Responsabilidad_civil__c;
                    pro[0].HDI4I_Hora_cronometro__c = prospecto.HDI4I_Hora_cronometro__c;
                    pro[0].HDI4I_Campana_cotizador_web__c = prospecto.HDI4I_Campana_cotizador_web__c;
                    try{
                        update pro[0];
                        mensaje = 'Actualizado con POST '+ pro[0].id + ' '+pro[0].HDI4I_Id_Oportunidad_web__c;
                        correo = 'Se ha actualizado con POST: '+pro[0].HDI4I_Id_Oportunidad_web__c;
                        ActivarCrono = true;
                        newItem.ORG_Estado__c = 'Procesado';
                    }catch(DmlException e){
                        System.debug('Error actualizando datos de prospecto: ' + e.getMessage());
                        newItem.ORG_Estado__c = 'No procesado';
                        newItem.ORG_DescriptionError__c = e.getMessage();
                    }            
                    
                }
                // Verifica si existe oportunidad para actualizar - Fix 31-01-20222 
                if(prospecto.HDI4I_Paso_cotizacion_web__c == 'Contratar' || prospecto.HDI4I_Paso_cotizacion_web__c == 'Éxito'){
                    oportunidad = ApiHDI.ConstructorOppo(createApi);
                    
                    if(oportunidad.HDI4I_Banco__c  == '1'){
                        oportunidad.HDI4I_Banco__c = 'BANCO BICE';
                    } else if(oportunidad.HDI4I_Banco__c  == '2'){
                        oportunidad.HDI4I_Banco__c = 'BANCO CHILE';
                    } else if(oportunidad.HDI4I_Banco__c  == '3'){
                        oportunidad.HDI4I_Banco__c = 'BANCO ESTADO';
                    } else if(oportunidad.HDI4I_Banco__c  == '6'){
                        oportunidad.HDI4I_Banco__c = 'BANCO BCI';
                    } else if(oportunidad.HDI4I_Banco__c  == '8'){
                        oportunidad.HDI4I_Banco__c = 'CITIBANK';
                    } else if(oportunidad.HDI4I_Banco__c  == '9'){
                        oportunidad.HDI4I_Banco__c = 'CORPBANCA';
                    } else if(oportunidad.HDI4I_Banco__c  == '10'){
                        oportunidad.HDI4I_Banco__c = 'BANCO DEL DESARROLLO';
                    } else if(oportunidad.HDI4I_Banco__c  == '11'){
                        oportunidad.HDI4I_Banco__c = 'BANCO SANTANDER SANTIAGO';
                    } else if(oportunidad.HDI4I_Banco__c  == '12'){
                        oportunidad.HDI4I_Banco__c = 'BANCO SUDAMERICANO';
                    } else if(oportunidad.HDI4I_Banco__c  == '13'){
                        oportunidad.HDI4I_Banco__c = 'SECURITY PACIFIC';
                    } else if(oportunidad.HDI4I_Banco__c  == '14'){
                        oportunidad.HDI4I_Banco__c = 'BANCO BBVA';
                    } else if(oportunidad.HDI4I_Banco__c  == '28'){
                        oportunidad.HDI4I_Banco__c = 'SCOTIABANK';
                    } else if(oportunidad.HDI4I_Banco__c  == '30'){
                        oportunidad.HDI4I_Banco__c = 'BANCO ITAU';
                    } else if(oportunidad.HDI4I_Banco__c  == '31'){
                        oportunidad.HDI4I_Banco__c = 'BANCO FALABELLA';
                    } else if(oportunidad.HDI4I_Banco__c  == '99'){
                        oportunidad.HDI4I_Banco__c = 'SIN BANCO';
                    } else{
                        oportunidad.HDI4I_Banco__c = 'BANCO DESCONOCIDO';
                    }
                    system.debug(oportunidad.HDI4I_Banco__c);
                }
                
                //Verifica si el id de la oportunidad existe en una oportunidad ya creada. de ser true, actualiza los datos de esa oportunidad.
                if(ApiHDI.existeOportunidad(prospecto.HDI4I_Id_Oportunidad_web__c)== true){
                    
                    Opportunity opo = new Opportunity();
                    
                    opo = ApiHDI.llamarOppo(prospecto.HDI4I_Id_Oportunidad_web__c);
                    
                    opo.HDI4I_Deducible__c = prospecto.HDI4I_Deducible__c;
                    opo.HDI4I_Auto_reemplazo__c = prospecto.HDI4I_Auto_reemplazo__c;
                    opo.HDI4I_Responsabilidad_civil__c = prospecto.HDI4I_Responsabilidad_civil__c;
                    opo.HDI4I_Codigo_de_producto_elegido__c = prospecto.HDI4I_Codigo_de_producto_elegido__c;
                    opo.LeadSource = prospecto.LeadSource;
                    opo.HDI4I_Paso_cotizacion_web__c = prospecto.HDI4I_Paso_cotizacion_web__c;
                    opo.HDI4I_Vehiculo_nuevo__c = prospecto.HDI4I_Vehiculo_nuevo__c;
                    opo.HDI4I_Codigo_de_producto_elegido__c = prospecto.HDI4I_Codigo_de_producto_elegido__c;
                    opo.HDI4I_Prioridad__c = prospecto.HDI4I_Prioridad__c;
                    opo.HDI4I_Tipo_de_pago__c = prospecto.HDI4I_Tipo_de_pago__c;
                    opo.HDI4I_Patente_del_vehiculo__c = prospecto.HDI4I_Patente_del_vehiculo__c;
                    opo.HDI4I_Hora__c = prospecto.HDI4I_Hora__c;
                    opo.HDI4I_Minuto__c = prospecto.HDI4I_Minuto__c;
                    opo.HDI4I_Hora_cronometro__c = prospecto.HDI4I_Hora_cronometro__c;
                    opo.BECS_NumeroSimulacion__c = prospecto.BECS_NumeroSimulacion__c;
                    opo.HDI4I_Campana_cotizador_web__c = prospecto.HDI4I_Campana_cotizador_web__c;
                    //Se verifica el paso de cotización web. Actuaiza los últimos datos de los pasos al momento de pagar.
                    if(prospecto.HDI4I_Paso_cotizacion_web__c == 'Contratar' || prospecto.HDI4I_Paso_cotizacion_web__c == 'Éxito'){
                        if(opo.HDI4I_Dueno_vehiculo__c == 'Sí'){
                            
                        }
                        opo.HDI4I_Nombres_asegurado__c = prospecto.FirstName;
                        opo.HDI4I_Apellido_paterno_asegurado__c  = prospecto.LastName;
                        opo.HDI4I_Numero_chasis__c = oportunidad.HDI4I_Numero_chasis__c;
                        opo.HDI4I_Numero_motor__c = oportunidad.HDI4I_Numero_motor__c;
                        opo.HDI4I_Banco__c = oportunidad.HDI4I_Banco__c;
                        opo.HDI4I_Tipo_tarjeta__c = oportunidad.HDI4I_Tipo_tarjeta__c;
                        opo.HDI4I_Numero_tarjeta__c = oportunidad.HDI4I_Numero_tarjeta__c;
                        opo.HDI4I_Numero_cuenta__c = oportunidad.HDI4I_Numero_cuenta__c;
                        opo.HDI4I_Dia_cargo__c = oportunidad.HDI4I_Dia_cargo__c;
                        opo.HDI4I_Sucursal__c = oportunidad.HDI4I_Sucursal__c;
                        opo.HDI4I_Numero_transaccion__c = oportunidad.HDI4I_Numero_transaccion__c;            
                        
                    }            
                    
                    try{                
                        update opo;
                        
                        if(prospecto.HDI4I_Paso_cotizacion_web__c == 'Contratar'){
                            mensaje = ' Oportunidad actualizada con PUT '+opo.HDI4I_Paso_cotizacion_web__c;
                            correo = 'Se actualizó la oportunidad: '+opo.HDI4I_Id_Oportunidad_web__c+' paso Contratar';
                            
                            ActivarCrono = true;
                        } else {
                            mensaje = ' Oportunidad actualizada con POST '+opo.HDI4I_Paso_cotizacion_web__c;
                            correo = 'Se actualizó la oportunidad: '+opo.HDI4I_Id_Oportunidad_web__c+' paso '+opo.HDI4I_Paso_cotizacion_web__c;
                            ActivarCrono = true;
                        }
                        newItem.ORG_Estado__c = 'Procesado';
                    }catch(DmlException e){
                        System.debug('Error: ' + e.getMessage());
                        newItem.ORG_Estado__c = 'No procesado';
                        newItem.ORG_DescriptionError__c = e.getMessage();
                    }
                } 
                // Verificar si existe oportunidad para actualizar - Fix 31-01-20222 
                else {
                    if(ApiHDI.cuentaYaCreada(prospecto.HDI4I_RUT_del_cliente__c)== true){
                        Opportunity opor = new Opportunity();                   
                        List<Account> cuenta;
                        cuenta = [select id, PersonMobilePhone, HDI4I_RUT_del_cliente__c, HDI4I_Digito_verificador_rut_cliente__c, HDI4I_UTMGoogle__c from Account where HDI4I_RUT_del_cliente__c =: prospecto.HDI4I_RUT_del_cliente__c];
                        if(prospecto.HDI4I_Paso_cotizacion_web__c == '1000'){
                            prospecto.HDI4I_Paso_cotizacion_web__c = 'Elegir';
                        }
                        opor.AccountId = cuenta[0].id;
                        opor.Name = prospecto.HDI4I_Id_Oportunidad_web__c;
                        opor.HDI4I_Paso_cotizacion_web__c = prospecto.HDI4I_Paso_cotizacion_web__c;
                        opor.HDI4I_Prioridad__c = prospecto.HDI4I_Prioridad__c;
                        opor.HDI4I_Numero_contacto__c = cuenta[0].PersonMobilePhone;
                        opor.HDI4I_RUT_del_cliente__c = cuenta[0].HDI4I_RUT_del_cliente__c;
                        opor.HDI4I_Auto_reemplazo__c = prospecto.HDI4I_Auto_reemplazo__c;
                        opor.HDI4I_Ano_del_vehiculo__c = prospecto.HDI4I_Ano_del_vehiculo__c;
                        opor.HDI4I_Campana_cotizador_web__c = prospecto.HDI4I_Campana_cotizador_web__c;
                        opor.HDI4I_Codigo_de_producto_elegido__c = prospecto.HDI4I_Codigo_de_producto_elegido__c;
                        opor.HDI4I_Deducible__c = prospecto.HDI4I_Deducible__c;
                        opor.HDI4I_Digito_verificador_rut_cliente__c = cuenta[0].HDI4I_Digito_verificador_rut_cliente__c;
                        opor.HDI4I_Digito_verif_rut_dueno_vehiculo__c = prospecto.HDI4I_Digito_verif_rut_dueno_vehiculo__c;
                        opor.HDI4I_Fecha_envio_cotizacion__c = prospecto.HDI4I_Fecha_envio_cotizacion__c;
                        opor.HDI4I_Id_Marca_vehiculo__c = prospecto.HDI4I_Id_Marca_vehiculo__c;
                        opor.HDI4I_Id_Modelo_vehiculo__c = prospecto.HDI4I_Id_Modelo_vehiculo__c;
                        opor.HDI4I_IdTarifa__c = prospecto.HDI4I_IdTarifa__c;
                        opor.HDI4I_Marca__c = prospecto.HDI4I_Marca__c;
                        opor.HDI4I_Modelo__c = prospecto.HDI4I_Modelo__c;
                        opor.HDI4I_Pago_primera_cuota__c = prospecto.HDI4I_Pago_primera_cuota__c;
                        opor.HDI4I_Patente_del_vehiculo__c = prospecto.HDI4I_Patente_del_vehiculo__c;
                        opor.HDI4I_Prima_cotizo_seguro__c = prospecto.HDI4I_Prima_cotizo_seguro__c;
                        opor.HDI4I_Producto_seleccionado__c = prospecto.HDI4I_Producto_seleccionado__c;
                        opor.HDI4I_Responsabilidad_civil__c = prospecto.HDI4I_Responsabilidad_civil__c;
                        opor.HDI4I_RUT_dueno_del_vehiculo__c = prospecto.HDI4I_RUT_dueno_del_vehiculo__c;//verificar despues este campo para comprobar si cliente y pagador son los mismos
                        opor.HDI4I_Tipo_de_pago__c = prospecto.HDI4I_Tipo_de_pago__c;
                        opor.HDI4I_Tipo_de_vehiculo__c = prospecto.HDI4I_Tipo_de_vehiculo__c;
                        opor.HDI4I_UTMGoogle__c = cuenta[0].HDI4I_UTMGoogle__c;
                        opor.HDI4I_Dueno_vehiculo__c = prospecto.HDI4I_Dueno_vehiculo__c;
                        opor.HDI4I_Oportunidad_gestionada__c = prospecto.HDI4I_Oportunidad_gestionada__c;
                        opor.HDI4I_Vehiculo_nuevo__c = prospecto.HDI4I_Vehiculo_nuevo__c;
                        opor.HDI4I_Vehiculo_tiene_patente__c = prospecto.HDI4I_Vehiculo_tiene_patente__c;
                        opor.HDI4I_Id_Oportunidad_web__c = prospecto.HDI4I_Id_Oportunidad_web__c;
                        opor.HDI4I_Hora_cronometro__c = prospecto.HDI4I_Hora_cronometro__c;
                        opor.HDI4I_Oportunidad_asignada__c = false;
                        opor.StageName = 'Nuevo';
                        opor.CloseDate = ApiHDI.fechaCierre();
                        opor.LeadSource = 'VSV2';
                        opor.CurrencyIsoCode = 'CLF';
                        opor.BECS_NumeroSimulacion__c = prospecto.BECS_NumeroSimulacion__c;
                        opor.HDI4I_Campana_cotizador_web__c = prospecto.HDI4I_Campana_cotizador_web__c;
                        try{
                            opor.OwnerId = ownerId;
                            insert opor;
                            
                            if(opor.HDI4I_Paso_cotizacion_web__c.equals('Elegir')){
                                system.debug('Este es el id de la oportunidad asignada a una cuenta existente: '+opor.id);
                                mensaje = ' Se crea oportunidad manualmente con paso Elegir';
                                
                                correo = 'Se convierte prospecto '+prospecto.HDI4I_Id_Oportunidad_web__c+' con cuenta existente';
                                //system.debug(ApiHDI.existeOportunidad(opor.HDI4I_Id_Oportunidad_web__c));
                            }else {
                                mensaje = ' se crea oportunidad manualmente con paso '+opor.HDI4I_Paso_cotizacion_web__c;
                                correo = 'Se convierte prospecto '+prospecto.HDI4I_Id_Oportunidad_web__c+' con cuenta existente';
                                ActivarCrono = true;
                            }
                            newItem.ORG_Estado__c = 'Procesado';
                        }catch(DmlException e){
                            System.debug('Error: ' + e.getMessage());
                            newItem.ORG_Estado__c = 'No procesado';
                            newItem.ORG_DescriptionError__c = e.getMessage();
                        }  
                    } else{          
                        try{
                            prospecto.OwnerId = ownerId;
                            insert prospecto;
                            mensaje = 'Insertado con POST '+prospecto.id+' '+prospecto.HDI4I_Id_Oportunidad_web__c;
                            correo = 'Se ha creado con POST: '+prospecto.HDI4I_Id_Oportunidad_web__c;
                            ActivarCrono = true;
    
                            newItem.ORG_Estado__c = 'Procesado';
                        }catch(DmlException e){
                            System.debug('Error: ' + e.getMessage());
                            newItem.ORG_Estado__c = 'No procesado';
                            newItem.ORG_DescriptionError__c = e.getMessage();
                        }            
                    }
                }
            //}
            //system.debug(ApiHDI.prospectoExiste(prospecto.HDI4I_Id_Oportunidad_web__c));
            
            if(mensaje == ' enviado a oportunidad con PUT' || mensaje == ' actualizado con PUT ok' || ActivarCrono == true){
                
                cr = ApiHDI.cronometro(prospecto.HDI4I_Id_Oportunidad_web__c, prospecto.HDI4I_Hora__c, prospecto.HDI4I_Minuto__c, tiempoCrono, prospecto.HDI4I_Hora_cronometro__c);
            }
            
            respuesta = mensaje + ' '+cr;
        }
        catch(Exception ex) {
            System.debug('Error: ' + ex.getMessage());
            newItem.ORG_Estado__c = 'No procesado';
            newItem.ORG_DescriptionError__c = ex.getMessage();
        }
    } */
}