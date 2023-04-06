public class HDI_WrapperSiniestros_SIN {
    //EVENTO
    public String numeroEvento {get;set;}

    //DATOS GENERALES VEHICULO
    public Datetime fechaIngresoDenuncio {get;set;}
    public String numeroSiniestro {get;set;}
    public String origenCaso {get;set;}
    public Datetime fechaOcurrencia {get;set;}
    public String relato {get;set;}
    public Date fechaConstancia {get;set;}
    public string numeroConstancia {get;set;}
    public String comisaria {get;set;}
    public String juzgado {get;set;}
    public String comuna {get;set;}
    public String causaNumero {get;set;}
    public Datetime fechaCitacion {get;set;}
    public String lesionados {get;set;}
    public String centroAsistencial {get;set;}
    public String alcoholemia {get;set;}

    //DATOS DENUNCIANTE
    public String nombreDenunciante {get;set;}
    public String apellidosDenunciante {get;set;}
    public String emailDenunciante {get;set;}

    //DATOS ASEGURADO
    public String nombreAsegurado {get;set;}
    public String apellidosAsegurado {get;set;}
    public String rutAsegurado {get;set;}
    public String dvAsegurado {get;set;}
    public String celularAsegurado {get;set;}
    public String emailAsegurado {get;set;}
    public String culpabilidadAsegurado {get;set;}
    public String numeroPoliza {get;set;}
    public String ramo {get;set;}
    public String producto {get;set;}
    public Integer certificado {get;set;}

    //DATOS CONDUCTOR
    public String nombreConductor {get;set;}
    public String apellidosConductor {get;set;}
    public String rutConductor {get;set;}
    public String dvConductor {get;set;}

    //DATOS VEHICULO
    public Integer marcaModelo {get;set;}
    public String marca {get;set;}
    public String modelo {get;set;}
    public String anioVehiculo {get;set;}
    public String patenteVehiculo {get;set;}

    //TERCEROS
    public List<Tercero> terceros {get;set;}

    public class Tercero{
        public String tipo {get;set;}
        public String rutConductor {get;set;}
        public String dvConductor {get;set;}
        public String nombreConductor {get;set;}
        public String apellidoConductor {get;set;}
        public String celularConductor {get;set;}
        public String emailConductor {get;set;}
        public String direccionConductor {get;set;}
        public String rutPropietario {get;set;}
        public String dvPropietario {get;set;}
        public String nombrePropietario {get;set;}
        public String apellidoPropietario {get;set;}
        public String celularPropietario {get;set;}
        public String emailPropietario {get;set;}
        public String direccionPropietario {get;set;}
        public Integer marcaModelo {get;set;}
        public String descripcionMarcaVehiculo {get;set;}
        public String descripcionModeloVehiculo {get;set;}
        public String aseguradoraVehiculo {get;set;}
        public String numeroPolizaVehiculo {get;set;}
        public String patenteVehiculo {get;set;}
    }

    //DATOS LIQUIDADOR
    public Datetime fechaAsignacion {get;set;}
    public Integer idLiquidador {get;set;}
    public String tipoLiquidador {get;set;}
    public String telefonoLiquidador {get;set;}

    //DATOS TALLER
    public String rutTaller {get;set;}
    public String dvTaller {get;set;}
    public String nombreTaller {get;set;}
    public String sucursalTaller {get;set;}
    public String direccionTaller {get;set;}
    public String telefonoTaller {get;set;}
    public String emailTaller {get;set;}

    //DATOS ASESOR Y EJECUTIVO
    public Integer idAsesor {get;set;}
    public String telefonoAsesor {get;set;}
    public Integer idEjecutivo {get;set;}

    public HDI_WrapperSiniestros_SIN() {

    }
}