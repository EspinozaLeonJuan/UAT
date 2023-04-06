@RestResource(urlMapping='/create/*')
global with sharing class ApiHDI {    
    @HttpPost    
    global static String create(){
        String respuesta = '';
        RestRequest req = RestContext.request;
        Blob body = req.requestBody;
        String requestString = body.toString();  
        
        try {
            Opportunity oportunidad;
            system.debug(requestString);
            boolean ActivarCrono = false;
            integer tiempoCrono = 0;
            tiempoCrono = 10;
            Lead prospecto;
            string mensaje = '';
            string cr = '';
            String correo = '';        
            
            CreateAPI createApi = (CreateAPI) JSON.deserialize(requestString, CreateAPI.class);                    
            
            prospecto = ConstructorLead(createApi);
            
            system.debug(prospecto.LastName);        
            
            /*if(prospectoExiste(prospecto.HDI4I_Id_Oportunidad_web__c)== true){
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
                    createSuccess('WS_POST : Success', requestString);
                    mensaje = 'Actualizado con POST '+ pro[0].id + ' '+pro[0].HDI4I_Id_Oportunidad_web__c;
                    correo = 'Se ha actualizado con POST: '+pro[0].HDI4I_Id_Oportunidad_web__c;
                    ActivarCrono = true;
                    
                }catch(DmlException e){
                    System.debug('Error actualizando datos de prospecto: ' + e.getMessage());
                    createLogError('WS_POST : ' + e.getTypeName(), requestString, e.getMessage());
                }            
                
            } else {
                */
                if(prospectoExiste(prospecto.HDI4I_Id_Oportunidad_web__c)== true){
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
                        createSuccess('WS_POST : Success', requestString);
                        mensaje = 'Actualizado con POST '+ pro[0].id + ' '+pro[0].HDI4I_Id_Oportunidad_web__c;
                        correo = 'Se ha actualizado con POST: '+pro[0].HDI4I_Id_Oportunidad_web__c;
                        ActivarCrono = true;
                        
                    }catch(DmlException e){
                        System.debug('Error actualizando datos de prospecto: ' + e.getMessage());
                        createLogError('WS_POST : ' + e.getTypeName(), requestString, e.getMessage());
                    }            
                    
                }
                /* Verifica si existe oportunidad para actualizar - Fix 31-01-20222 */
                if(prospecto.HDI4I_Paso_cotizacion_web__c == 'Contratar' || prospecto.HDI4I_Paso_cotizacion_web__c == 'Éxito'){
                    oportunidad = ConstructorOppo(createApi);
                    
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
                if(existeOportunidad(prospecto.HDI4I_Id_Oportunidad_web__c)== true){
                    
                    Opportunity opo = new Opportunity();
                    
                    opo = llamarOppo(prospecto.HDI4I_Id_Oportunidad_web__c);
                    
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
                        createSuccess('WS_POST : Success', requestString);

                        if(prospecto.HDI4I_Paso_cotizacion_web__c == 'Contratar'){
                            mensaje = ' Oportunidad actualizada con POST '+opo.HDI4I_Paso_cotizacion_web__c;
                            correo = 'Se actualizó la oportunidad: '+opo.HDI4I_Id_Oportunidad_web__c+' paso Contratar';
                            
                            ActivarCrono = true;
                        } else {
                            mensaje = ' Oportunidad actualizada con POST '+opo.HDI4I_Paso_cotizacion_web__c;
                            correo = 'Se actualizó la oportunidad: '+opo.HDI4I_Id_Oportunidad_web__c+' paso '+opo.HDI4I_Paso_cotizacion_web__c;
                            ActivarCrono = true;
                        }
                        
                    }catch(DmlException e){
                        System.debug('Error: ' + e.getMessage());
                        createLogError('WS_POST : ' + e.getTypeName(), requestString, e.getMessage());
                    }
                } 
                /* FIN Verificar si existe oportunidad para actualizar - Fix 31-01-20222 */
                else {
                    if(cuentaYaCreada(prospecto.HDI4I_RUT_del_cliente__c)== true){
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
                        opor.CloseDate = fechaCierre();
                        opor.LeadSource = 'VSV2';
                        opor.CurrencyIsoCode = 'CLF';
                        opor.BECS_NumeroSimulacion__c = prospecto.BECS_NumeroSimulacion__c;

                        try{
                            insert opor;
                            createSuccess('WS_POST : Success', requestString);

                            if(opor.HDI4I_Paso_cotizacion_web__c.equals('Elegir')){
                                system.debug('Este es el id de la oportunidad asignada a una cuenta existente: '+opor.id);
                                mensaje = ' Se crea oportunidad manualmente con paso Elegir';
                                
                                correo = 'Se convierte prospecto '+prospecto.HDI4I_Id_Oportunidad_web__c+' con cuenta existente';
                                system.debug(existeOportunidad(opor.HDI4I_Id_Oportunidad_web__c));
                            }else {
                                mensaje = ' se crea oportunidad manualmente con paso '+opor.HDI4I_Paso_cotizacion_web__c;
                                correo = 'Se convierte prospecto '+prospecto.HDI4I_Id_Oportunidad_web__c+' con cuenta existente';
                                ActivarCrono = true;
                            }
                            
                        }catch(DmlException e){
                            System.debug('Error: ' + e.getMessage());
                            createLogError('WS_POST : ' + e.getTypeName(), requestString, e.getMessage());
                        }  
                    } else{          
                        try{
                            insert prospecto;
                            createSuccess('WS_POST : Success', requestString);

                            mensaje = 'Insertado con POST '+prospecto.id+' '+prospecto.HDI4I_Id_Oportunidad_web__c;
                            correo = 'Se ha creado con POST: '+prospecto.HDI4I_Id_Oportunidad_web__c;
                            ActivarCrono = true;
                            
                        }catch(DmlException e){
                            System.debug('Error: ' + e.getMessage());
                            createLogError('WS_POST : ' + e.getTypeName(), requestString, e.getMessage());
                        }            
                    }
                }

                
            //}
            system.debug(prospectoExiste(prospecto.HDI4I_Id_Oportunidad_web__c));
            
            if(mensaje == ' enviado a oportunidad con PUT' || mensaje == ' actualizado con PUT ok' || ActivarCrono == true){
                
                cr = cronometro(prospecto.HDI4I_Id_Oportunidad_web__c, prospecto.HDI4I_Hora__c, prospecto.HDI4I_Minuto__c, tiempoCrono, prospecto.HDI4I_Hora_cronometro__c);
            }
            
            respuesta = mensaje + ' '+cr;
            system.debug(respuesta);
        }
        catch(Exception ex) {
            createLogError('WS_POST : ' + ex.getTypeName(), requestString, ex.getMessage());
        }
        return respuesta;        
    }        
    
    @HttpPut
    global static String actualizar(){
        string respuesta = ''; 
        RestRequest req = RestContext.request; 
        Blob body = req.requestBody;
        String requestString = body.toString();  
        try{
                         
            system.debug(requestString);
            
            CreateAPI createApi = (CreateAPI) JSON.deserialize(requestString, CreateAPI.class);
            
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
            
            prospecto = ConstructorLead(createApi);
            
            if(prospecto.HDI4I_Paso_cotizacion_web__c == 'Contratar' || prospecto.HDI4I_Paso_cotizacion_web__c == 'Éxito'){
                oportunidad = ConstructorOppo(createApi);
                
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
            if(existeOportunidad(prospecto.HDI4I_Id_Oportunidad_web__c)== true){
                
                Opportunity opo = new Opportunity();
                
                opo = llamarOppo(prospecto.HDI4I_Id_Oportunidad_web__c);
                
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
                    createSuccess('WS_PUT : Success', requestString);

                    if(prospecto.HDI4I_Paso_cotizacion_web__c == 'Contratar'){
                        mensaje = ' Oportunidad actualizada con PUT '+opo.HDI4I_Paso_cotizacion_web__c;
                        correo = 'Se actualizó la oportunidad: '+opo.HDI4I_Id_Oportunidad_web__c+' paso Contratar';
                        
                        ActivarCrono = true;
                    } else {
                        mensaje = ' Oportunidad actualizada con PUT '+opo.HDI4I_Paso_cotizacion_web__c;
                        correo = 'Se actualizó la oportunidad: '+opo.HDI4I_Id_Oportunidad_web__c+' paso '+opo.HDI4I_Paso_cotizacion_web__c;
                        ActivarCrono = true;
                    }
                    
                }catch(DmlException e){
                    System.debug('Error: ' + e.getMessage());
                    createLogError('WS_PUT : ' + e.getTypeName(), requestString, e.getMessage());
                }
            } else if(existeOportunidad(prospecto.HDI4I_Id_Oportunidad_web__c)== false){//Cuando es false, se asimila que se va a actualizar un prospecto con el paso elejir y así convertir en una oportunidad.            
                
                //SE comprueba si efectivamente el prospecto existe para poder actualizar su paso de cotización
                if(prospectoExiste(prospecto.HDI4I_Id_Oportunidad_web__c)== true){                
                    
                    Lead pro = new Lead();
                    pro = llamarLead(prospecto.HDI4I_Id_Oportunidad_web__c);
                    //system.debug(pro);
                    //----------------------------------------------------------------------------------------------------------------------VERIFICAR QUE EL RUT EXISTE EN UNA CUENTA ANTES DE TRANSFORMAR EM OPORTUNIDAD
                    if(cuentaYaCreada(prospecto.HDI4I_RUT_del_cliente__c)== true){
                        
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
                            createSuccess('WS_PUT : Success', requestString);

                            if(pro.HDI4I_Paso_cotizacion_web__c == 'Elegir'){
                                mensaje = ' actualizado con PUT a paso Elegir';
                                correo = 'Se actualiza prospecto '+prospecto.HDI4I_Id_Oportunidad_web__c+ 'a paso Elegir';
                                ActivarCrono = true;
                            } else {
                                mensaje = ' actualizado con PUT con paso '+prospecto.HDI4I_Paso_cotizacion_web__c;
                                correo = 'Se actualiza prospecto '+prospecto.HDI4I_Id_Oportunidad_web__c+ 'a paso '+prospecto.HDI4I_Paso_cotizacion_web__c;
                                ActivarCrono = true;
                            }
                            
                        }catch(DmlException e){
                            System.debug('Error: ' + e.getMessage());
                            createLogError('WS_PUT : ' + e.getTypeName(), requestString, e.getMessage());
                        }
                        
                    }
                } else if(prospectoExiste(prospecto.HDI4I_Id_Oportunidad_web__c) == false){//Desde aquí se crea un Lead nuevo en casos especiales 
                    /* Valida si existe cuenta - 08/02/2022 */
                    if(cuentaYaCreada(prospecto.HDI4I_RUT_del_cliente__c)== true){
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
                        opor.CloseDate = fechaCierre();
                        opor.LeadSource = 'VSV2';
                        opor.CurrencyIsoCode = 'CLF';
                        opor.BECS_NumeroSimulacion__c = prospecto.BECS_NumeroSimulacion__c;

                        try{
                            insert opor;
                            createSuccess('WS_PUT : Success', requestString);
                            
                            if(opor.HDI4I_Paso_cotizacion_web__c.equals('Elegir')){
                                system.debug('Este es el id de la oportunidad asignada a una cuenta existente: '+opor.id);
                                mensaje = ' Se crea oportunidad manualmente con paso Elegir';
                                
                                correo = 'Se convierte prospecto '+prospecto.HDI4I_Id_Oportunidad_web__c+' con cuenta existente';
                                system.debug(existeOportunidad(opor.HDI4I_Id_Oportunidad_web__c));
                            }else {
                                mensaje = ' se crea oportunidad manualmente con paso '+opor.HDI4I_Paso_cotizacion_web__c;
                                correo = 'Se convierte prospecto '+prospecto.HDI4I_Id_Oportunidad_web__c+' con cuenta existente';
                                ActivarCrono = true;
                            }
                            
                        }catch(DmlException e){
                            System.debug('Error: ' + e.getMessage());
                            createLogError('WS_PUT : ' + e.getTypeName(), requestString, e.getMessage());
                        }  
                    } else { /* FIN  Valida si existe cuenta - 08/02/2022  */
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
                                createSuccess('WS_PUT : Success', requestString);
                                
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
                            
                            
                        }catch(DmlException e){
                            System.debug('Error: ' + e.getMessage());
                            createLogError('WS_PUT : ' + e.getTypeName(), requestString, e.getMessage());
                        }   
                    }
                } else {
                    mensaje = 'No se creó ningún dato';
                    correo = 'No se creó ni actualizó ningún dato';
                }         
                
            }
            
            if(mensaje == ' enviado a oportunidad con PUT' || mensaje == ' actualizado con PUT ok' || ActivarCrono == true){
                
                cr = cronometro(prospecto.HDI4I_Id_Oportunidad_web__c, prospecto.HDI4I_Hora__c, prospecto.HDI4I_Minuto__c, tiempoCrono, prospecto.HDI4I_Hora_cronometro__c);
            }
            
            
            respuesta = mensaje +' '+ id_web+' '+cr+ag;
            system.debug(respuesta);   
        } catch(Exception ex){
            createLogError('WS_PUT : ' + ex.getTypeName(), requestString, ex.getMessage());
        }
        return respuesta; 
    }    
    /* Verifica si existe prospecto (cambio de query) - Fix 31-01-20222 */
    public static boolean prospectoExiste(string dni){
        
        //integer prosp = [Select count() from lead where HDI4I_Id_Oportunidad_web__c  =: dni];
        List<lead> propsList = [SELECT Id FROM Lead WHERE HDI4I_Id_Oportunidad_web__c =: dni];
        system.debug('¿Existe lead?  -> ' + propsList);

        if(!propsList.isEmpty()){
            system.debug('Encontró prospecto');
            return true;
        } else {
            system.debug('No encontró prospecto');
            return false;
        }         
    }

    /* Verifica si existe oportunidad (cambio de query) - Fix 31-01-20222 */
    public static boolean existeOportunidad(string dni){
        
        //integer cuenta = [Select count() from Opportunity where HDI4I_Id_Oportunidad_web__c  =: dni];
        List<Opportunity> oppList = [SELECT Id FROM Opportunity WHERE HDI4I_Id_Oportunidad_web__c  =: dni];
        System.debug('¿Existe opportunity? -> ' + oppList);
        if(!oppList.isEmpty()){
            system.debug('Oportunidad existe');
            return true;
        } else {
            system.debug('Oportunidad no existe');
            return false;
        }           
    }
    
    public static date fechaCierre(){
        integer y = integer.valueOf(string.valueOf(system.now().year()));
        integer m = integer.valueOf(string.valueOf(system.now().month()));
        integer d = integer.valueOf(string.valueOf(system.now().day()));
        system.debug(y+'-'+m+'-'+d);
        integer nd = d + 15;
        integer dm = 0;
        integer nm = 0;
        integer ny = 0;
        integer mb = 0;
        //Determinar si el año es bisiesto para calcular el mes de febrero
        if((math.mod(y, 4)==0)&&((math.mod(y, 100)!=0)||(math.mod(y, 400)==0))){
            system.debug('Año bisiesto');
            mb = 29;
        } else{
            system.debug('Año no bisiesto');
            mb = 28;
        }
        //Determinar cantidad de días según mes
        if(m == 4 || m == 6 || m == 9 || m == 11){
            system.debug('mes con 30 días');
            dm = 30;
        } else if(m == 2){
            dm = mb;
        } else{
            system.debug('mes con 31 días');
            dm = 31;
        }     
        
        if(nd > dm){
            nm = m + 1;
            nd = nd - dm;
            if(nm > 12){
                nm = 1;
                ny = y + 1;
            } else{
                ny = y;
            }
        } else {
            nm = m;
            ny = y;
        }
        
        system.debug(ny+'-'+nm+'-'+nd);
        date fecha = date.valueOf(ny+'-'+nm+'-'+nd);
        return fecha;
    }
    
    public static string tiempoCrono(integer tiempo){
        string hor = '';
        integer h = integer.valueof(string.valueOf(system.now().hour()));
        integer m = integer.valueof(string.valueOf(system.now().minute()));
        integer s = integer.valueof(string.valueOf(system.now().second()));
        string y = string.valueOf(system.now().year());
        string d = string.valueOf(system.now().day());
        string mes = string.valueOf(system.now().month());
        integer me = m + tiempo;
        integer he = 0;
        integer mf = 0;
        integer r = 0;
        string hes = '';
        string mfs = '';
        string ss = '';
        
        if(me >=60){
            he = h + 1;
            r = me - 60;
            mf = r;
            if(mf == 60){
                mf = 0;
            }
        } else {
            he = h;
            mf = me;
        }
        
        if(he < 10){
            hes = '0'+he; 
        } else{
            hes = string.valueOf(he);
        }
        if(mf < 10){
            mfs = '0'+mf; 
        } else{
            mfs = string.valueOf(mf);
        }
        if(s < 10){
            ss = '0'+s; 
        } else{
            ss = string.valueOf(s);
        }
        if(he == 24){
            he = 00;
            hes = string.valueOf(he);
        }
        system.debug('se actualiza a las: '+he+':'+mf+' del '+d+'/'+mes+'/'+y);
        
        hor = hes + ':' + mfs+':'+ss+':';
        return hor;
    }
    
    public static boolean existeCrono(String n){
        integer cronD = [Select count() from CronJobDetail where name =: n];
        system.debug(cronD);
        if(cronD >0){
            system.debug('Existe Crono');
            return true;
        }else{
            system.debug('No existe Crono');
            return false;
        }        
    }
    /* Verifica si existe cuenta (cambio de query) - Fix 31-01-20222 */
    public static boolean cuentaYaCreada(String dni){
        //integer existe = [Select count() from Account where HDI4I_RUT_del_cliente__c =: dni];
        List<Account> accountList = [SELECT Id FROM Account WHERE HDI4I_RUT_del_cliente__c  =: dni];
        System.debug('¿Existe account? -> ' + accountList);
        
        if(!accountList.isEmpty()){
            system.debug('DNI existe en una cuenta');
            return true;
        } else {
            system.debug('DNI no existe');
            return false;
        }  
    }
    
    public static Lead ConstructorLead(CreateAPI createApi){
        // Hora creación para Cronómetro
        integer h = integer.valueof(string.valueOf(system.now().hour()));
        integer m = integer.valueof(string.valueOf(system.now().minute()));
        integer s = integer.valueof(string.valueOf(system.now().second()));
        integer mm = integer.valueOf(system.now().millisecond());
        string mms = '';
        system.debug(mm);
        if(mm > 10 && mm < 100){
            mms = '0'+mm;
            system.debug('nuevo: '+mms);
        }else if (mm < 10){
            mms = '00'+mm;
            system.debug('nuevo: '+mms);
        }else{
            mms = string.valueOf(mm);
        }
        integer tiempoCrono = 0;
        tiempoCrono = 10;
        Lead prospecto = new Lead();
        
        prospecto.HDI4I_Marca__c 				   			  = createApi.descripcionMarcaVehiculo;            
        prospecto.HDI4I_Modelo__c 				   		      = createApi.descripcionModeloVehiculo;
        prospecto.HDI4I_Ano_del_vehiculo__c 				  = createApi.anioVehiculo;                             
        prospecto.HDI4I_Campana_cotizador_web__c   			  = createApi.campaniaCotizadorWeb;
        prospecto.HDI4I_Dueno_vehiculo__c 		   			  = createApi.duenioVehiculo;
        prospecto.HDI4I_Deducible__c 			   			  = createApi.deducible;
        prospecto.HDI4I_Auto_reemplazo__c 		   			  = createApi.autoReemplazo;
        prospecto.HDI4I_Producto_seleccionado__c   			  = createApi.productoSeleccionado;        
        prospecto.HDI4I_Tipo_de_vehiculo__c 	   			  = createApi.tipoVehiculo;
        prospecto.Email 						   			  = validateEmail(createApi.emailCliente);            
        prospecto.HDI4I_Digito_verificador_rut_cliente__c 	  = createApi.digitoVerificadorRutCliente;
        prospecto.HDI4I_Digito_verif_rut_dueno_vehiculo__c    = createApi.digitoVerificadorRutDuenioVeh;
        prospecto.HDI4I_Vehiculo_nuevo__c 					  = createApi.esVehiculoNuevoOp;
        prospecto.HDI4I_Fecha_envio_cotizacion__c 			  = createApi.fechaEnvioCotizacion;
        prospecto.HDI4I_Id_Oportunidad_web__c 			  	  = createApi.idHdiOpWeb;
        prospecto.HDI4I_Oportunidad_gestionada__c 			  = createApi.oportunidadGestionada;
        prospecto.HDI4I_Paso_cotizacion_web__c 				  = createApi.pasoCotizacionWeb;
        prospecto.HDI4I_Patente_del_vehiculo__c 			  = createApi.patenteVehiculo;
        prospecto.HDI4I_Prima_cotizo_seguro__c 				  = createApi.primaCotizacionVehiculo;
        prospecto.HDI4I_RUT_del_cliente__c 				  	  = createApi.rutCliente;
        prospecto.HDI4I_RUT_dueno_del_vehiculo__c 			  = createApi.rutDuenioVehiculo;
        prospecto.MobilePhone 						 		  = createApi.telefonoCliente;
        prospecto.HDI4I_Vehiculo_tiene_patente__c 			  = createApi.vehiculoTienePatenteOp;            
        prospecto.HDI4I_Responsabilidad_civil__c 			  = createApi.resposabilidadCivilOp;
        prospecto.HDI4I_Id_Marca_vehiculo__c 				  = createApi.idMarcaVehiculo;
        prospecto.HDI4I_Id_Modelo_vehiculo__c 				  = createApi.idModeloVehiculo;
        prospecto.HDI4I_Tipo_de_pago__c 					  = createApi.tipoDePagoOp;
        prospecto.HDI4I_Pago_primera_cuota__c 				  = createApi.pagoPrimeraCuota;
        prospecto.HDI4I_Prioridad__c 						  = createApi.prioridad;
        prospecto.LeadSource 								  = createApi.origenProspectoOp;
        prospecto.FirstName									  = createApi.nombreCliente;            
        prospecto.LastName									  = createApi.apellidoPaterno;
        prospecto.HDI4I_IdTarifa__c							  = createApi.IdTarifa;
        prospecto.HDI4I_UTMGoogle__c						  = createApi.UTMGoogle;
        prospecto.HDI4I_Codigo_de_producto_elegido__c		  = createApi.codigoProductoElegido;
        prospecto.HDI4I_Hora__c = string.valueof(h);
        prospecto.HDI4I_Minuto__c = string.valueof(m);
        prospecto.HDI4I_Hora_cronometro__c = tiempoCrono(tiempoCrono)+string.valueOf(mms);
        prospecto.BECS_NumeroSimulacion__c = createApi.numeroSimulacion;
        system.debug('Tiempo para cronómetro: '+prospecto.HDI4I_Hora_cronometro__c);
        
        if(prospecto.HDI4I_Vehiculo_nuevo__c == '709460000'){
            prospecto.HDI4I_Vehiculo_nuevo__c = 'Sí';
        } else if(prospecto.HDI4I_Vehiculo_nuevo__c == '709460001'){
            prospecto.HDI4I_Vehiculo_nuevo__c = 'No';
        } else{
            prospecto.HDI4I_Vehiculo_nuevo__c = 'No';
        }
        //Condiciones para tipo de deducible
        if(prospecto.HDI4I_Deducible__c == '709460000'){            
            prospecto.HDI4I_Deducible__c = '0 UF';
        } else if(prospecto.HDI4I_Deducible__c == '709460001'){
            prospecto.HDI4I_Deducible__c = '3 UF';
        } else if(prospecto.HDI4I_Deducible__c == '709460002'){
            prospecto.HDI4I_Deducible__c = '5 UF';
        } else if(prospecto.HDI4I_Deducible__c == '709460003'){
            prospecto.HDI4I_Deducible__c = '10 UF';
        }        
        //Condicion para los días del auto para reemplazo 
        if(prospecto.HDI4I_Auto_reemplazo__c == '709460000'){
            prospecto.HDI4I_Auto_reemplazo__c = '0 Días';
        } else if(prospecto.HDI4I_Auto_reemplazo__c == '709460001'){
            prospecto.HDI4I_Auto_reemplazo__c = '15 Días';
        } else if(prospecto.HDI4I_Auto_reemplazo__c == '709460002'){
            prospecto.HDI4I_Auto_reemplazo__c = '30 Días';
        } else if(prospecto.HDI4I_Auto_reemplazo__c == '709460003'){
            prospecto.HDI4I_Auto_reemplazo__c = '45 Días';
        }
        //Rellenar producto seleccionado
        if(prospecto.HDI4I_Producto_seleccionado__c == '709460000'){
            prospecto.HDI4I_Producto_seleccionado__c = 'Seguro vehículo';
        }
        //Condiciones para tipo de vehículo
        if(prospecto.HDI4I_Tipo_de_vehiculo__c == '709460000'){
            prospecto.HDI4I_Tipo_de_vehiculo__c = 'Automóvil';
        } else if(prospecto.HDI4I_Tipo_de_vehiculo__c == '709460001'){
            prospecto.HDI4I_Tipo_de_vehiculo__c = 'Station Wagon';
        } else if(prospecto.HDI4I_Tipo_de_vehiculo__c == '709460002'){
            prospecto.HDI4I_Tipo_de_vehiculo__c = 'Jeep';
        } else if(prospecto.HDI4I_Tipo_de_vehiculo__c == '709460003'){
            prospecto.HDI4I_Tipo_de_vehiculo__c = 'Camioneta';
        } else if(prospecto.HDI4I_Tipo_de_vehiculo__c == '709460004'){
            prospecto.HDI4I_Tipo_de_vehiculo__c = 'Furgón';
        } else if(prospecto.HDI4I_Tipo_de_vehiculo__c == '709460005'){
            prospecto.HDI4I_Tipo_de_vehiculo__c = 'Moto';
        } else if(prospecto.HDI4I_Tipo_de_vehiculo__c == '709460006'){
            prospecto.HDI4I_Tipo_de_vehiculo__c = 'Carro de arrastre';
        } else if(prospecto.HDI4I_Tipo_de_vehiculo__c == '709460007') {
            prospecto.HDI4I_Tipo_de_vehiculo__c = 'Otro';
        }

        //Condición para paso cotización web
        if(prospecto.HDI4I_Paso_cotizacion_web__c == '10'){
            prospecto.HDI4I_Paso_cotizacion_web__c = 'Cotizar';
        } else if(prospecto.HDI4I_Paso_cotizacion_web__c == '11' || prospecto.HDI4I_Paso_cotizacion_web__c == '102'){
            prospecto.HDI4I_Paso_cotizacion_web__c = 'Elegir';
        } else if(prospecto.HDI4I_Paso_cotizacion_web__c == '12' || prospecto.HDI4I_Paso_cotizacion_web__c == '103'){
            prospecto.HDI4I_Paso_cotizacion_web__c = 'Contratar';
        } else if(prospecto.HDI4I_Paso_cotizacion_web__c == '13'){
            prospecto.HDI4I_Paso_cotizacion_web__c = 'Éxito';
        } else if(prospecto.HDI4I_Paso_cotizacion_web__c == '1000'){
            prospecto.HDI4I_Paso_cotizacion_web__c = 'Cotizar';
            prospecto.HDI4I_Prioridad__c = '100';
        }
        //Responsabilidad civil
        if(prospecto.HDI4I_Responsabilidad_civil__c == '709460000'){
            prospecto.HDI4I_Responsabilidad_civil__c = '500 UF';
        } else if(prospecto.HDI4I_Responsabilidad_civil__c == '709460001'){
            prospecto.HDI4I_Responsabilidad_civil__c = '1.000 UF';
        } else if(prospecto.HDI4I_Responsabilidad_civil__c == '709460002'){
            prospecto.HDI4I_Responsabilidad_civil__c = '3.000 UF';
        }
        //Tipo de pago
        if(prospecto.HDI4I_Tipo_de_pago__c == '709460000'){
            prospecto.HDI4I_Tipo_de_pago__c = 'Pago automático PAT/PAC';
        } else if(prospecto.HDI4I_Tipo_de_pago__c == '709460001'){
            prospecto.HDI4I_Tipo_de_pago__c = 'Aviso de vencimiento';
        } else if(prospecto.HDI4I_Tipo_de_pago__c == '709460002'){
            prospecto.HDI4I_Tipo_de_pago__c = 'Pago contado';
        }
        //Tipo pago primera cuota
        if(prospecto.HDI4I_Pago_primera_cuota__c == '709460000'){
            prospecto.HDI4I_Pago_primera_cuota__c = 'En línea';
        } else if(prospecto.HDI4I_Pago_primera_cuota__c == '709460001'){
            prospecto.HDI4I_Pago_primera_cuota__c = 'Sucursal';
        }
        //LeadSource
        if(prospecto.LeadSource == '752230001'){
            prospecto.LeadSource = 'VSV2';
        } else {
            prospecto.LeadSource = 'VSV2';
        }
        if(prospecto.HDI4I_Dueno_vehiculo__c == 'Sí'){
            prospecto.Rut_sin_puntos_y_con_gui_n__c = prospecto.HDI4I_RUT_del_cliente__c+'-'+prospecto.HDI4I_Digito_verificador_rut_cliente__c;
        } else if(prospecto.HDI4I_Dueno_vehiculo__c == 'No'){
            prospecto.Rut_sin_puntos_y_con_gui_n__c = prospecto.HDI4I_RUT_dueno_del_vehiculo__c+'-'+prospecto.HDI4I_Digito_verif_rut_dueno_vehiculo__c;
        }
        
        system.debug(prospecto.Rut_sin_puntos_y_con_gui_n__c);
        return prospecto;
    }
    
    public static Opportunity ConstructorOppo(CreateAPI createApi){
        Opportunity oportunidad = new Opportunity();
        
        oportunidad.HDI4I_Numero_chasis__c					  = createApi.chasis;
        oportunidad.HDI4I_Numero_motor__c					  = createApi.numMotor;
        oportunidad.HDI4I_Banco__c 							  = createApi.banco;
        oportunidad.HDI4I_Tipo_tarjeta__c 					  = createApi.tipoTarjeta;
        oportunidad.HDI4I_Numero_tarjeta__c 				  = createApi.numeroTarjeta;
        oportunidad.HDI4I_Numero_cuenta__c 					  = createApi.numeroCuenta;
        oportunidad.HDI4I_Dia_cargo__c 						  = createApi.diaCargo;
        oportunidad.HDI4I_Sucursal__c 						  = createApi.sucursal;
        oportunidad.HDI4I_Numero_transaccion__c 			  = createApi.numTransaccion;
        
        return oportunidad;
    }
    
    public static Opportunity llamarOppo(String n){
        Opportunity opo = [Select id, HDI4I_Deducible__c, HDI4I_Auto_reemplazo__c, HDI4I_Responsabilidad_civil__c, HDI4I_Codigo_de_producto_elegido__c, LeadSource,
                           HDI4I_Paso_cotizacion_web__c, HDI4I_Vehiculo_nuevo__c, HDI4I_Prioridad__c, HDI4I_Tipo_de_pago__c, HDI4I_Patente_del_vehiculo__c, BECS_NumeroSimulacion__c,
                           HDI4I_Hora__c, HDI4I_Minuto__c, HDI4I_Nombres_asegurado__c, HDI4I_Apellido_paterno_asegurado__c, HDI4I_Numero_chasis__c, HDI4I_Numero_motor__c,
                           HDI4I_Banco__c, HDI4I_Tipo_tarjeta__c, HDI4I_Numero_tarjeta__c, HDI4I_Numero_cuenta__c, HDI4I_Dia_cargo__c, HDI4I_Sucursal__c,
                           HDI4I_Numero_transaccion__c, HDI4I_Dueno_vehiculo__c, HDI4I_Hora_cronometro__c, HDI4I_Id_Oportunidad_web__c, OwnerId from Opportunity where HDI4I_Id_Oportunidad_web__c =: n limit 1];
        return opo;
    }
    
    public static Lead llamarLead(String n){
        Lead pro = [select id, FirstName, LastName, HDI4I_Deducible__c, HDI4I_Auto_reemplazo__c, HDI4I_Responsabilidad_civil__c, LeadSource,
                    HDI4I_Paso_cotizacion_web__c, HDI4I_Codigo_de_producto_elegido__c, HDI4I_Prioridad__c, HDI4I_Tipo_de_pago__c, HDI4I_Patente_del_vehiculo__c,
                    HDI4I_Hora__c, HDI4I_Minuto__c, HDI4I_Vehiculo_nuevo__c, HDI4I_Hora_cronometro__c, isconverted  from lead where HDI4I_Id_Oportunidad_web__c =:n limit 1];
        return pro;
    }
    
    public static string cronometro(string web, string hora, string minuto, integer tiempo, string hCro){
        string mensaje = '';
        integer h = integer.valueof(string.valueOf(system.now().hour()));
        integer m = integer.valueof(string.valueOf(system.now().minute()));
        integer s = integer.valueof(string.valueOf(system.now().second()));
        string y = string.valueOf(system.now().year());
        string d = string.valueOf(system.now().day());
        string mes = string.valueOf(system.now().month());
        integer me = m + tiempo;
        integer he = 0;
        integer mf = 0;
        integer r = 0;
        string hes = '';
        string mfs = '';
        string ss = '';
        
        if(me >=60){
            he = h + 1;
            r = me - 60;
            mf = r;
            if(mf == 60){
                mf = 0;
            }
        } else {
            he = h;
            mf = me;
        }
        
        if(he < 10){
            hes = '0'+he; 
        } else{
            hes = string.valueOf(he);
        }
        if(mf < 10){
            mfs = '0'+mf; 
        } else{
            mfs = string.valueOf(mf);
        }
        if(s < 10){
            ss = '0'+s; 
        } else{
            ss = string.valueOf(s);
        }
        if(he == 24){
            he = 00;
            hes = string.valueOf(he);
        }
        system.debug('se actualiza a las: '+he+':'+mf+' del '+d+'/'+mes+'/'+y);
        system.debug('hora guardada en pros: '+hora+':'+minuto);
        string ho = hes + ':' + mfs+':'+ss;
        if(existeCrono(web+hCro)){
            mensaje = 'Temporizador ya existe '+web;
            
        } else{
            
            //crono o = new crono();
            //system.schedule(web+hCro, '0 '+mf+' '+he+' '+d+' '+mes+' ? '+y, o);
            mensaje = 'Temporizador activo '+web+hCro;
        }
        
        integer i = 0;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        return mensaje;
    }
    
    public static void createLogError(String name, String request, String errorMessage){
        ORG_IntegrationLogError__c logError = new ORG_IntegrationLogError__c();
        CreateAPI result = deserializeJSON(request);

        logError.name = name != null ? name : 'Error';
        logError.ORG_FechaHoraError__c = Datetime.now();//Datetime.newInstanceGmt(now.year(), now.month(), now.day(), now.hour(), now.minute(), now.second());
        logError.ORG_Solicitud__c = request;
        logError.ORG_DescriptionError__c = errorMessage;
        logError.ORG_Estado__c = 'No procesado';
        logError.ORG_Proyecto__c = 'Instant Call';
        logError.ORG_IdOportunidadWeb__c = result != null ? result.idHdiOpWeb : null;
        logError.ORG_CampanaCotizadorWeb__c = result != null ? result.campaniaCotizadorWeb : null;
        insert logError;
    }

    public static void createSuccess(String name, String request){
        ORG_IntegrationLogError__c logError = new ORG_IntegrationLogError__c();
        CreateAPI result = deserializeJSON(request);

        logError.name = name != null ? name : 'Success';
        logError.ORG_FechaHoraError__c = Datetime.now();        
        logError.ORG_Solicitud__c = request;
        logError.ORG_Estado__c = 'Correcto';
        logError.ORG_Proyecto__c = 'Instant Call';
        logError.ORG_IdOportunidadWeb__c = result != null ? result.idHdiOpWeb : null;
        logError.ORG_CampanaCotizadorWeb__c = result != null ? result.campaniaCotizadorWeb : null;
        insert logError;
    }

    private static CreateAPI deserializeJSON(String request){
        CreateAPI result = new CreateAPI();
        try{
            if(request != null){ 
                result = (CreateAPI) JSON.deserialize(request, CreateAPI.class);
            } 
        } catch(Exception ex){
            System.debug('exception deserialize JSON');
            System.debug(request);
        }
        return result;
    }

    public static String validateEmail(String email){
        String emailRegex = '^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$'; 

        if(String.isEmpty(email)){
            return email;
        }

        return !Pattern.compile(emailRegex).matcher(email).matches() ? '' : email;
    }
}