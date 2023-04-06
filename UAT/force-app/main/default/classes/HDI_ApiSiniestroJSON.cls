public class HDI_ApiSiniestroJSON {

    public String tipoEvento{get;set;}
    public String estadoDenuncio{get;set;}
    public String numeroSiniestro{get;set;}
    public String polizaConcatenado{get;set;} // completo
    public String ramo{get;set;}
    public String producto{get;set;}
    public String poliza{get;set;} //number
    public String certificado{get;set;}
    public String fechaOcurrencia{get;set;}
    public String fechaDenuncia{get;set;}
    public String canalDenuncia{get;set;}
    public String rutAsegurado{get;set;} //
    public String nombreAsegurado{get;set;} //
    public String celularAsegurado{get;set;} //
    public String mailContacto{get;set;} //
    public String rutConductor{get;set;}
    public String nombreConductor{get;set;}
    public String marca{get;set;}
    public String modelo{get;set;}
    public String anio{get;set;} //consulta por lectura de caracteres 'ñ'
    public String patente{get;set;}
    public String idLiquidador{get;set;}  
    public String liquidador{get;set;}
    public String rutTaller{get;set;}
    public String nombreTaller{get;set;}
    public String relato{get;set;}
    public String idInvolucrado{get;set;}
    public String nombreInvolucrado{get;set;}
    public String rutInvolucrado{get;set;}
    public String fechaRecepcionVehiculo{get;set;}
    public String idCobertura{get;set;}
    public String nombreCobertura{get;set;}
    public String fechaReasignacionTaller{get;set;}
    public String fechaReasignacionLiquidador{get;set;}
    public String fechaRechazo{get;set;}
    public String provision{get;set;}
    public String deducible{get;set;}       
    public String fechaEvaluacion{get;set;}
    public String deducibleInteligente{get;set;}
    public String fechaActualizaciondeducibleInteligente{get;set;}
    public String nroOT{get;set;}
    public String fechaEnvioOt{get;set;}
    public String nroOC{get;set;}
    public String fechaEntregaVehiculo{get;set;}
    public String fechaGeneracionFiniquito{get;set;}
    public List<involucrado> involucrados{get;set;}
    
    public class Involucrado{
        public String idInvolucrado{get;set;} //
        public String nombreTercero{get;set;}
        public String rutTercero{get;set;} 
    }

}