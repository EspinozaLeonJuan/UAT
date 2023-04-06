public with sharing class HDI4I_OpportunityUrlController {
    public Opportunity oportunidad {get;set;}
    public User usuario {get; set;}
    public string cadena {get;set;}
    public String mensaje {get; set;}
    public string url {get; set;}

    public id getId {get; set;}{
        getid = ApexPages.currentPage().getParameters().get('id');
    } 

    public HDI4I_OpportunityUrlController(Apexpages.StandardController controller){
        String esNuevo;
        String patente = 'ET0000';
        Set <Id> oppId = new Set <Id>();
        oppId.add(this.getId);
        List<Opportunity> opo = new BECS_OpportunitySelector().byId(oppId);
        this.oportunidad = opo[0];
        
        this.usuario = [select HDI4I_UsuarioId__c, HDI4I_VendedorId__c, HDI4I_usuario__c, HDI4I_clave__c, HDI4I_CorredorId__c from User where id =: oportunidad.OwnerId];
        String tipoVehiculo = TipoV(oportunidad.HDI4I_Tipo_de_vehiculo__c); 
        String deducible = TipoD(oportunidad.HDI4I_Deducible__c);
        
        
        if (oportunidad.HDI4I_Vehiculo_nuevo__c == 'Si') {
            esNuevo = 'true';
        } else {
            esNuevo = 'false';
        }
        if (oportunidad.HDI4I_Patente_del_vehiculo__c != null) {
            patente = oportunidad.HDI4I_Patente_del_vehiculo__c;
        }

        String urlString = updateString(oportunidad, esNuevo, patente, tipoVehiculo, deducible, usuario);

        string responseBody = HDI4I_UrlCall.makePost(urlString).getBody();
        boolean response = responseBody.contains('{"UrlSimulador":');
        if (response) {
            HDI4I_UrlController.Url redirect = (HDI4I_UrlController.Url) System.JSON.deserialize(responseBody, HDI4I_UrlController.Url.class);
            if (redirect.UrlSimulador == '') {
                
                this.mensaje = redirect.Transaccion.glosaError.remove('\u000a').remove('Se ha producido un error en el ingreso de parámetros en el método: GetUrlCotizador. Los errores a continuación:');

            }else{
                this.url = redirect.UrlSimulador;
                try {
                    if(oportunidad.StageName == 'Nuevo' || oportunidad.StageName == 'Cotizando'){
                        oportunidad.StageName = 'Envío Cotización';
                        //update oportunidad;
                    }
                } catch (Exception e) {
                    System.debug('Error: ' + e.getCause());    
                }
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

    public String TipoD(String ded){
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
    }
    
    public PageReference updateOpp(){
        Set <Id> oppId = new Set <Id>();
        oppId.add(this.getId);
        List<Opportunity> oportu = new BECS_OpportunitySelector().byId(oppId);
        if (oportu[0].StageName == 'Nuevo' || oportu[0].StageName == 'Cotizando') {
            oportu[0].StageName = 'Envío Cotización' ;
            update oportu;
            return null;
        } else {return null;}
    }

    public static String updateString(Opportunity oportunidad, String esNew, String patent, String tipoVeh, String deducible, User usuario) {
    
                
        oportunidadVenta opp = new oportunidadVenta();
          
        opp.PatenteVehiculo = patent;
        opp.RutContratante = oportunidad.HDI4I_RUT_del_cliente__c;
        opp.DvContratante = oportunidad.HDI4I_Digito_verificador_rut_cliente__c;
        opp.RutAsegurado = oportunidad.HDI4I_RUT_dueno_del_vehiculo__c;
        opp.DvAsegurado = oportunidad.HDI4I_Digito_verif_rut_dueno_vehiculo__c;
        opp.TipoVehiculo =tipoVeh;//oportunidad.HDI4I_RUT_dueno_del_vehiculo__c;
        opp.MarcaVehiculo = oportunidad.HDI4I_Id_Marca_vehiculo__c; 
        opp.ModeloVehiculo = oportunidad.HDI4I_Id_Modelo_vehiculo__c;
        opp.AnioVehiculo = oportunidad.HDI4I_Ano_del_vehiculo__c; 
        opp.EsNuevo = esNew; 
        opp.FechaNacimientoContratante = null;
        opp.TipoUso ='1';
        opp.MesesVigenciaTarifa = '12';
        opp.Deducible = deducible;
        opp.FormaPago = null;
        opp.IdCampagna= '1';
        opp.EmailContratante= oportunidad.Account.personemail;
        opp.FonoContratante= oportunidad.Account.PersonMobilePhone;
        opp.CodigoOportunidad= oportunidad.id;
        opp.CodigoProducto = oportunidad.HDI4I_Codigo_de_producto_elegido__c;
        opp.UsuarioId= usuario.HDI4I_UsuarioId__c;
        opp.VendedorId=usuario.HDI4I_VendedorId__c;
        
        
        cotizar newCotizar = new cotizar();
        newCotizar.oportunidadVenta = opp;
        newCotizar.rutCorredor=usuario.HDI4I_CorredorId__c;
        newCotizar.usuario=usuario.HDI4I_usuario__c; //
        newCotizar.clave=usuario.HDI4I_clave__c;
        
        string serial = JSON.serialize(newCotizar);
        return serial;
        
    }
	
    public class cotizar{
        public oportunidadVenta oportunidadVenta {get;set;}
        public String rutCorredor {set; get;}
        public String usuario {set; get;}
        public String clave {set; get;}    
    }
    
    public  class oportunidadVenta {
        public String PatenteVehiculo {set; get;}
        public String RutContratante {set; get;}
        public String DvContratante {set; get;}
        public String RutAsegurado {set; get;}
        public String DvAsegurado {set; get;}
        public String TipoVehiculo {set; get;}
        public String MarcaVehiculo {set; get;}
        public String ModeloVehiculo {set; get;}
        public String AnioVehiculo {set; get;}
        public String EsNuevo {set; get;}
        public String FechaNacimientoContratante {set; get;}
        public String TipoUso {set; get;}
        public String MesesVigenciaTarifa {set; get;}
        public String Deducible {set; get;}
        public String FormaPago {set; get;}
        public String IdCampagna {set; get;}
        public String EmailContratante {set; get;}
        public String FonoContratante {set; get;}
        public String CodigoOportunidad {set; get;}
        public String CodigoProducto {set; get;}
        public String UsuarioId {set; get;}
        public String VendedorId {set; get;}
    }
}