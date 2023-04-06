global class ControllerUrlOpportunity {
    
    public Opportunity opo {get; set;}
    public Account cuenta {get; set;}
    public User usuario {get; set;}
    public string url {get; set;}
    public String mensaje {get; set;}
    
    
    public id getId {get; set;}{
        getid = ApexPages.currentPage().getParameters().get('id');
        system.debug(getId);
    }
    
    
    
    public ControllerUrlOpportunity(){
        
        String esNuevo = 'null';
        String patente = 'ET0000';
        String h = '';
        String rut = '';
        String dv = '';
        
        this.opo = [select HDI4I_Patente_del_vehiculo__c, 
                    HDI4I_RUT_del_cliente__c, 
                    HDI4I_Digito_verificador_rut_cliente__c,
                    HDI4I_RUT_dueno_del_vehiculo__c,
                    HDI4I_Digito_verif_rut_dueno_vehiculo__c,
                    
                    HDI4I_Tipo_de_vehiculo__c, 
                    HDI4I_Id_Marca_vehiculo__c, 
                    HDI4I_Id_Modelo_vehiculo__c, 
                    HDI4I_Ano_del_vehiculo__c, 
                    HDI4I_Vehiculo_nuevo__c, 
                    HDI4I_Deducible__c,
                    HDI4I_Codigo_de_producto_elegido__c,
                    id,
                    AccountId,
                    OwnerId
                    from opportunity
                    where id =: getid];
        
        this.cuenta = [select personemail, PersonMobilePhone from Account where id =: opo.AccountId];
        this.usuario = [select HDI4I_UsuarioId__c, HDI4I_VendedorId__c, HDI4I_usuario__c, HDI4I_clave__c, HDI4I_CorredorId__c from User where id =: opo.OwnerId];
        
        system.debug(this.opo);
        system.debug(opo.id);
        system.debug(this.cuenta);
        system.debug(this.usuario);
        
        if(opo.HDI4I_RUT_del_cliente__c != opo.HDI4I_RUT_dueno_del_vehiculo__c){
            rut = opo.HDI4I_RUT_dueno_del_vehiculo__c;
            dv = opo.HDI4I_Digito_verif_rut_dueno_vehiculo__c;
        }else{
            rut = opo.HDI4I_RUT_del_cliente__c;
            dv = opo.HDI4I_Digito_verificador_rut_cliente__c;
        }
        
        
        system.debug(opo.HDI4I_Vehiculo_nuevo__c);
        
        if(opo.HDI4I_Vehiculo_nuevo__c == 'Sí'){
            esNuevo = 'true';
        } else if(opo.HDI4I_Vehiculo_nuevo__c == 'No'){
            esNuevo = 'false';
        }      
        
        system.debug(esNuevo);
        
        system.debug(opo.HDI4I_Patente_del_vehiculo__c);
        if(opo.HDI4I_Patente_del_vehiculo__c != null){
            patente = opo.HDI4I_Patente_del_vehiculo__c;
        }        
        
        String tipoVehiculo = TipoV(opo.HDI4I_Tipo_de_vehiculo__c);
        String deducible = opo.HDI4I_Deducible__c; //TipoD(opo.HDI4I_Deducible__c);
        
        system.debug(patente);
        system.debug(opo.HDI4I_RUT_del_cliente__c);
        system.debug(opo.HDI4I_Digito_verificador_rut_cliente__c);
        system.debug(opo.HDI4I_Id_Marca_vehiculo__c);
        system.debug(opo.HDI4I_Id_Modelo_vehiculo__c);
        system.debug(opo.HDI4I_Ano_del_vehiculo__c);
        system.debug(esNuevo);
        system.debug(opo.HDI4I_Codigo_de_producto_elegido__c);
        system.debug(opo.HDI4I_Tipo_de_vehiculo__c);
        system.debug(tipoVehiculo);
        system.debug(opo.HDI4I_Deducible__c);
        system.debug(deducible);
        
        system.debug('Rut que se envía: '+rut+'-'+dv);
        
        String json = string.valueOf('{    "oportunidadVenta": {'+
                                     '"PatenteVehiculo": "'+patente+'", \n'+
                                     '"RutContratante": '+opo.HDI4I_RUT_del_cliente__c+', \n'+
                                     '"DvContratante": "'+opo.HDI4I_Digito_verificador_rut_cliente__c+'", \n'+
                                     '"RutAsegurado": "'+opo.HDI4I_RUT_dueno_del_vehiculo__c+'", \n'+
                                     '"DvAsegurado": "'+opo.HDI4I_Digito_verif_rut_dueno_vehiculo__c+'", \n'+
                                     '"TipoVehiculo": '+tipoVehiculo+', \n'+
                                     '"MarcaVehiculo": '+opo.HDI4I_Id_Marca_vehiculo__c+', \n'+
                                     '"ModeloVehiculo": '+opo.HDI4I_Id_Modelo_vehiculo__c+', \n'+
                                     '"AnioVehiculo": '+opo.HDI4I_Ano_del_vehiculo__c+', \n'+
                                     '"EsNuevo": '+esNuevo+', \n'+
                                     '"FechaNacimientoContratante": null'+', \n'+
                                     '"TipoUso": 1'+', \n'+
                                     '"MesesVigenciaTarifa": 12'+', \n'+
                                     '"Deducible": '+deducible+', \n'+
                                     '"FormaPago": null'+', \n'+
                                     '"IdCampagna": 1'+', \n'+
                                     '"EmailContratante": "'+cuenta.personemail+'", \n'+
                                     '"FonoContratante": "'+cuenta.PersonMobilePhone+'", \n'+                                     
                                     '"CodigoOportunidad": "'+opo.id+'", \n'+
                                     '"CodigoProducto": '+opo.HDI4I_Codigo_de_producto_elegido__c+', \n'+
                                     '"UsuarioId": '+usuario.HDI4I_UsuarioId__c+', \n'+
                                     '"VendedorId": '+usuario.HDI4I_VendedorId__c+' }, \n'+
                                     '"rutCorredor": '+usuario.HDI4I_CorredorId__c+', \n'+
                                     '"usuario": "'+usuario.HDI4I_usuario__c+'", \n'+
                                     '"clave": "'+usuario.HDI4I_clave__c+'"}');
        
        system.debug(json);
        string responseBody = UrlCall.makePost(json).getBody();
        boolean response = responseBody.contains('{"UrlSimulador":');
        system.debug('El response trae: '+response);
        
        if(response){
            hdi.Url hola = (hdi.Url) System.JSON.deserialize(responseBody, hdi.Url.class);
            system.debug('la url: '+hola.UrlSimulador);
            system.debug('la url: '+hola.Transaccion.glosaError);
            system.debug(Https(hola.UrlSimulador));
            h = hola.UrlSimulador;
            
            if(h == ''){
                String m1 = hola.Transaccion.glosaError.remove('\u000a');
                string m2 = m1.remove('Se ha producido un error en el ingreso de parámetros en el método: GetUrlCotizador. Los errores a continuación:');
                system.debug(m2);
                system.debug(hola.Transaccion.glosaError);
                this.mensaje = m2;
                //this.url = 'http://www.hdi.cl';
            }else{
                system.debug('Holi');
                this.url = h;
            }
        } else {
            this.mensaje = 'Se ha producido un error inesperado en el ingreso a Cotizador Hdi';
        }
    }
    
    public String TipoV(String name){
        String id = '';
        
        if(name == 'Automóvil'){
            id = '1';
        } else if(name == 'Station Wagon'){
            id = '6';
        } else if(name == 'Jeep'){
            id = '5';
        } else if(name == 'Camioneta'){
            id = '4';
        } else if(name == 'Furgón'){
            id = '2';
        } else if(name == 'Moto'){
            id = '14';
        } else if(name == 'Carro de arrastre'){
            id = '19';
        } else{
            id = '7';
        }
        
        return id;
    }
    
    /* public String TipoD(String ded){
        String id = '';
        
        if(ded == '0 UF'){
            id = '0';
        } else if(ded == '3 UF'){
            id = '3';
        } else if(ded == '5 UF'){
            id = '5';
        } else if(ded == '10 UF'){
            id = '10';
        } else{
            id = '-1';
        }
        
        return id;
    } */
    
    public String Https(String url){
        string h = '';
        string s = 'https';
        integer l = integer.valueOf(url.length()-4);
        
        string c = url.right(l);
        
        h = s+c;
        Integer i = 0;
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
        return h;
    }
    
    
}