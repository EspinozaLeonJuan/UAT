public class HDI_WrapperSiniestros_SIN {
    //EVENTO
    public String numeroEvento {get;set;}

    //DATOS GENERALES VEHICULO
    public Datetime fechaIngresoDenuncio {get;set;}
    public String numeroSiniestro {get;set;}
    public String origenCaso {get;set;}
    public Datetime fechaOcurrencia {get;set;}
    public String relato {get;set;}
    public String relatoDanos {get; set;}
    public Date fechaConstancia {get;set;}
    public String numeroConstancia {get;set;}
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
    public String telefonoDeDenunciante {get;set;}

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
    public String certificado {get;set;}

    //DATOS CONDUCTOR
    public String nombreConductor {get;set;}
    public String apellidosConductor {get;set;}
    public String rutConductor {get;set;}
    public String dvConductor {get;set;}

    //DATOS VEHICULO
    public Double marcaModelo {get;set;}
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
        public String apellidosConductor {get;set;}
        public String celularConductor {get;set;}
        public String emailConductor {get;set;}
        public String direccionConductor {get;set;}
        public String rutPropietario {get;set;}
        public String dvPropietario {get;set;}
        public String nombrePropietario {get;set;}
        public String apellidosPropietario {get;set;}
        public String celularPropietario {get;set;}
        public String emailPropietario {get;set;}
        public String direccionPropietario {get;set;}
        public Double marcaModelo {get;set;}
        public String descripcionMarcaVehiculo {get;set;}
        public String descripcionModeloVehiculo {get;set;}
        public String aseguradoraVehiculo {get;set;}
        public String numeroPolizaVehiculo {get;set;}
        public String patenteVehiculo {get;set;}
        public Integer idTercero  {get;set;}
    }

    //DATOS LIQUIDADOR
    public String idLiquidador {get;set;}
    public String tipoLiquidador {get;set;}
    public String telefonoLiquidador {get;set;}
    public String emailLiquidador {get;set;}
    public DateTime fechaAsignacionLiquidador {get;set;}
    public DateTime fechaAsignacion {get;set;}

    //DATOS TALLER
    public String rutTaller {get;set;}
    public String dvTaller {get;set;}
    public String nombreTaller {get;set;}
    public String sucursalTaller {get;set;}
    public String direccionTaller {get;set;}
    public String telefonoTaller {get;set;}
    public String emailTaller {get;set;}
    public String tipoServicioTaller {get;set;}
    public DateTime fechaAsignacionTaller {get;set;}
    public DateTime fechaActualizacionEmailTaller {get;set;}
    public DateTime fechaActualizacionContactoTaller {get;set;}

    //DATOS ASESOR Y EJECUTIVO
    public String idAsesor {get;set;}
    public String emailAsesor {get;set;}
    public String telefonoAsesor {get;set;}
    public DateTime fechaAsignacionAsesor {get;set;}
    public DateTime fechaActualizacionEmailAsesor {get;set;}
    public DateTime fechaActualizacionContactoAsesor {get;set;}

    public String idEjecutivo {get;set;}
    public String emailEjecutivo {get;set;}
    public String telefonoEjecutivo {get;set;}
    public DateTime fechaAsignacionEjecutivo {get;set;}
    public DateTime fechaActualizacionEmailEjecutivo {get;set;}
    public DateTime fechaActualizacionContactoEjecutivo {get;set;}

    //DATOS REASIGNACION
    public DateTime fechaReasignacionLiquidador {get;set;}
    public DateTime fechaReasignacionAsesor {get;set;}
    public DateTime fechaReasignacionEjecutivo {get;set;}
    public DateTime fechaReasignacionTaller {get;set;}

    public HDI_WrapperSiniestros_SIN() {

    }
}