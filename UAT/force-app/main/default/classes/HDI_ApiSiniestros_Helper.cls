public class HDI_ApiSiniestros_Helper {

    private final Id  ID_SINIESTRO_DEFAULT = [SELECT Name,id FROM Group WHERE Name = 'Gestión Siniestros'].id;
    private final Id RECORD_TYPE_SINESTRO_DEFAULT = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName()
            .get('HDI_Siniestro_SIN')
            .getRecordTypeId();
    public static final String EVENTO_ASIGNACION = '110';
    public static final String EVENTO_REASIGNACION = '111';
    public static final String EVENTO_ACTUALIZACION = '112';
    private static final String PREFIJO = [SELECT prefijo__c, label FROM HDI_CfgPrefijo__mdt WHERE label = 'HDI_Prefijo_Chile'].prefijo__c;
    private static final TimeZone TZ = TimeZone.getTimeZone([SELECT TimeZoneSidKey FROM Organization].TimeZoneSidKey);
    private List<HDI4I_Tercero__c> listTerceros = new List<HDI4I_Tercero__c>();

    public Case processSIN(HDI_WrapperSiniestros_SIN wrapSin){
        Case siniestro = new Case();
        siniestro.TipoEvento__c = wrapSin.numeroEvento;                
        siniestro.HDIFechaHoraDeIngresoDenuncio__c = timeGMT(wrapSin.fechaIngresoDenuncio,siniestro.HDIFechaHoraDeIngresoDenuncio__c ); 
        siniestro.HDI4I_N_Siniestro__c = wrapSin.numeroSiniestro;
        siniestro.Origin = wrapSin.origenCaso;
        siniestro.HDI4I_Fecha_de_ocurrencia__c = timeGMT(wrapSin.fechaOcurrencia,siniestro.HDI4I_Fecha_de_ocurrencia__c);
        siniestro.HDI4I_Nombre_del_asegurado__c = wrapSin.nombreAsegurado;
        siniestro.HDIApellidosDelAsegurado__c = wrapSin.apellidosAsegurado;
        siniestro.HDI4I_Rut_del_asegurado__c = wrapSin.rutAsegurado;
        siniestro.HDIDVDelAsegurado__c = wrapSin.dvAsegurado;
        siniestro.HDI_CelularAsegurado__c = wrapSin.celularAsegurado != null && wrapSin.celularAsegurado != '' ? PREFIJO + wrapSin.celularAsegurado : null;
        siniestro.HDIEmailDelAsegurado__c = checkEmail(wrapSin.emailAsegurado); 
        siniestro.HDICulpabilidadDelAsegurado__c = wrapSin.culpabilidadAsegurado;
        siniestro.HDI4I_Poliza__c = wrapSin.numeroPoliza;
        siniestro.HDI4I_Ramo__c = wrapSin.ramo;
        siniestro.HDI4I_Producto__c = wrapSin.producto;
        siniestro.HDI4I_Certificado__c = !string.isEmpty(wrapSin.certificado) ? decimal.valueOf(wrapSin.certificado) : siniestro.HDI4I_Certificado__c ;
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
        siniestro.HDIRelato_Danos__c = wrapSin.relatoDanos;
        siniestro.HDIFechaConstancia__c = wrapSin.fechaConstancia;
        siniestro.HDINumConstancia__c = wrapSin.numeroConstancia;
        siniestro.HDIComisaria__c = wrapSin.comisaria;
        siniestro.HDIJuzgado__c = wrapSin.juzgado;
        siniestro.HDIComuna__c = wrapSin.comuna;
        siniestro.HDICausaNum__c = wrapSin.causaNumero;
        siniestro.HDIFechaCitacion__c = timeGMT(wrapSin.fechaCitacion, siniestro.HDIFechaCitacion__c);
        siniestro.HDILesionados__c =  wrapSin.lesionados;
        siniestro.HDICentroAsistencial__c = wrapSin.centroAsistencial;
        siniestro.HDIAlcoholemia__c = wrapSin.alcoholemia;
        siniestro.HDINombreDelDenunciante__c = wrapSin.nombreDenunciante;
        siniestro.HDIApellidosDelDenunciante__c = wrapSin.apellidosDenunciante;
        siniestro.HDIEmailDelDenunciante__c =  checkEmail(wrapSin.emailDenunciante);
        siniestro.HDITelefono_de_denunciante__c = PREFIJO+wrapSin.telefonoDeDenunciante;
        siniestro.OwnerId = ID_SINIESTRO_DEFAULT;                              
        siniestro.RecordTypeId = RECORD_TYPE_SINESTRO_DEFAULT;
        return siniestro;
    }

    public HDI4I_Tercero__c processTercero(HDI_WrapperSiniestros_SIN.Tercero terceroWrap, HDI_WrapperSiniestros_SIN wrapSin) {
        HDI4I_Tercero__c tercero = new HDI4I_Tercero__c();              
        tercero.HDITipoDeTercero__c = terceroWrap.tipo;
        tercero.HDI4I_Rut_tercero__c = terceroWrap.rutConductor;
        tercero.HDIDVDelConductorTercero__c = terceroWrap.dvConductor;
        tercero.HDI4I_Nombre_tercero__c = terceroWrap.nombreConductor;
        tercero.HDIApellidosDelConductorTercero__c = terceroWrap.apellidosConductor;
        tercero.HDICelularConductorTercero__c =terceroWrap.celularConductor != null &&terceroWrap.celularConductor != '' ? PREFIJO +terceroWrap.celularConductor : null; 
        tercero.HDIEmailDelConductorTercero__c = checkEmail(terceroWrap.emailConductor);
        tercero.HDIDireccionDelConductorTercero__c = terceroWrap.direccionConductor;
        tercero.HDIRutPropietarioTercero__c = terceroWrap.rutPropietario;
        tercero.HDIDVDelPropietarioTercero__c = terceroWrap.dvPropietario;
        tercero.HDINombreDelPropietarioTercero__c = terceroWrap.nombrePropietario;
        tercero.HDIApellidosDelPropietarioTercero__c = terceroWrap.apellidosPropietario;
        tercero.HDICelularPropietarioTercero__c = terceroWrap.celularPropietario != null &&terceroWrap.celularPropietario != '' ? PREFIJO +terceroWrap.celularPropietario : null;
        tercero.HDIEmailDelPropietarioTercero__c = checkEmail(terceroWrap.emailPropietario);
        tercero.HDIDireccionDelPropietarioTercero__c = terceroWrap.direccionPropietario;
        tercero.HDIDescripcionMarcaDelVHTercero__c = terceroWrap.descripcionMarcaVehiculo;
        tercero.HDIMarcaModeloDelVehiculoTercero__c = Decimal.valueOf(terceroWrap.marcaModelo);
        tercero.HDIDescripcionModeloDelVHTercero__c = terceroWrap.descripcionModeloVehiculo;
        tercero.HDIAseguradoraDelVehiculoTercero__c = terceroWrap.aseguradoraVehiculo;
        tercero.HDINPolizaDelVehiculoTercero__c= terceroWrap.numeroPolizaVehiculo;
        tercero.HDIPatenteDelVehiculoTercero__c = terceroWrap.patenteVehiculo;
        tercero.HDITerceroInvId__c = wrapSin.numeroSiniestro + '-' + terceroWrap.idTercero;
        tercero.HDINumeroSiniestro__c=wrapSin.numeroSiniestro;
        listTerceros.add(tercero);
        return tercero;
    }

    public Case updateSiniestro(HDI_WrapperSiniestros_SIN sinWrapp, Case sinUpdate, Map<String, User> mapUser){

        Case siniestro = new Case();
        siniestro.Id = sinUpdate.Id;

        if (sinWrapp.numeroEvento == EVENTO_ACTUALIZACION) {
            
            siniestro.HDIIdDelAsesor__c = (String)valueJSON(sinWrapp.idAsesor, sinUpdate.HDIIdDelAsesor__c);    
            siniestro.HDIEmail_Asesor__c = (String)valueJSON(sinWrapp.emailAsesor, sinUpdate.HDIEmail_Asesor__c);
            siniestro.HDITelefonoAsesor__c = (String)valueJSON(sinWrapp.telefonoAsesor, sinUpdate.HDITelefonoAsesor__c);
            siniestro.HDIFecha_actualizacion_email_Asesor__c = timeGMT(sinWrapp.fechaActualizacionEmailAsesor, sinUpdate.HDIFecha_actualizacion_email_Asesor__c);
            siniestro.HDIFecha_actualizacion_contacto_Asesor__c = timeGMT(sinWrapp.fechaActualizacionContactoAsesor, sinUpdate.HDIFecha_actualizacion_contacto_Asesor__c);
            siniestro.HDIIDEjecutivo__c = (String)valueJSON(sinWrapp.idEjecutivo, sinUpdate.HDIIDEjecutivo__c);
            siniestro.HDIEmail_Ejecutivo__c = (String)valueJSON(sinWrapp.emailEjecutivo, sinUpdate.HDIEmail_Ejecutivo__c);
            siniestro.HDITelefono_Ejecutivo__c = (String)valueJSON(sinWrapp.telefonoEjecutivo, sinUpdate.HDITelefono_Ejecutivo__c);
            siniestro.HDIFecha_actualizacion_email_Ejecutivo__c = timeGMT(sinWrapp.fechaActualizacionEmailEjecutivo, sinUpdate.HDIFecha_actualizacion_email_Ejecutivo__c);
            siniestro.HDIFecha_actualizacion_contacto_Ejecutiv__c = timeGMT(sinWrapp.fechaActualizacionContactoEjecutivo, sinUpdate.HDIFecha_actualizacion_contacto_Ejecutiv__c);
            siniestro.HDI4I_Rut_del_taller__c = (String)valueJSON(sinWrapp.rutTaller, sinUpdate.HDI4I_Rut_del_taller__c);
            siniestro.HDIDVDelTaller__c = (String)valueJSON(sinWrapp.dvTaller, sinUpdate.HDIDVDelTaller__c);
            siniestro.HDISucursalDelTaller__c = (String)valueJSON(sinWrapp.sucursalTaller, sinUpdate.HDISucursalDelTaller__c);
            siniestro.HDIEmailDelTaller__c = (String)valueJSON(sinWrapp.emailTaller, sinUpdate.HDIEmailDelTaller__c);
            siniestro.HDINumeroDeContactoDelTaller__c = (String)valueJSON(sinWrapp.telefonoTaller, sinUpdate.HDINumeroDeContactoDelTaller__c);
            siniestro.HDIFecha_actualizacion_contacto_Taller__c = timeGMT(sinWrapp.fechaActualizacionContactoTaller, sinUpdate.HDIFecha_actualizacion_contacto_Taller__c);
            siniestro.HDIFecha_actualizacion_email_Taller__c = timeGMT(sinWrapp.fechaActualizacionEmailTaller, sinUpdate.HDIFecha_actualizacion_email_Taller__c);
            siniestro.HDITipo_de_Servicio_Taller__c = (String)valueJSON(sinWrapp.tipoServicioTaller, sinUpdate.HDITipo_de_Servicio_Taller__c);

        } else {

            if (sinWrapp.numeroEvento == EVENTO_ASIGNACION){

                siniestro.HDI4I_ID_del_liquidador__c = (String)valueJSON(sinWrapp.idLiquidador, sinUpdate.HDI4I_ID_del_liquidador__c);
                siniestro.HDITipoDeLiquidador__c = (String)valueJSON(sinWrapp.tipoLiquidador, sinUpdate.HDITipoDeLiquidador__c);
                siniestro.HDIEmail_Liquidador__c = (String)valueJSON(sinWrapp.emailLiquidador, sinUpdate.HDIEmail_Liquidador__c);
                siniestro.HDITelefonoLiquidador__c = (String)valueJSON(sinWrapp.telefonoLiquidador, sinUpdate.HDITelefonoLiquidador__c);

                siniestro.HDI4I_Rut_del_taller__c = (String)valueJSON(sinWrapp.rutTaller, sinUpdate.HDI4I_Rut_del_taller__c);
                siniestro.HDIDVDelTaller__c = (String)valueJSON(sinWrapp.dvTaller, sinUpdate.HDIDVDelTaller__c);
                siniestro.HDI4I_Nombre_del_taller__c = (String)valueJSON(sinWrapp.nombreTaller, sinUpdate.HDI4I_Nombre_del_taller__c);
                siniestro.HDISucursalDelTaller__c = (String)valueJSON(sinWrapp.sucursalTaller, sinUpdate.HDISucursalDelTaller__c);
                siniestro.HDIDireccionDelTaller__c = (String)valueJSON(sinWrapp.direccionTaller, sinUpdate.HDIDireccionDelTaller__c);
                siniestro.HDINumeroDeContactoDelTaller__c = (String)valueJSON(sinWrapp.telefonoTaller, sinUpdate.HDINumeroDeContactoDelTaller__c);
                siniestro.HDIEmailDelTaller__c = (String)valueJSON(sinWrapp.emailTaller, sinUpdate.HDIEmailDelTaller__c);
                siniestro.HDITipo_de_Servicio_Taller__c = (String)valueJSON(sinWrapp.tipoServicioTaller, sinUpdate.HDITipo_de_Servicio_Taller__c);

                siniestro.HDIIDEjecutivo__c = (String)valueJSON(sinWrapp.idEjecutivo, sinUpdate.HDIIDEjecutivo__c);
                siniestro.HDIEmail_Ejecutivo__c = (String)valueJSON(sinWrapp.emailEjecutivo, sinUpdate.HDIEmail_Ejecutivo__c);
                siniestro.HDITelefono_Ejecutivo__c = (String)valueJSON(sinWrapp.telefonoEjecutivo, sinUpdate.HDITelefono_Ejecutivo__c);

                siniestro.HDIIdDelAsesor__c = (String)valueJSON(sinWrapp.idAsesor, sinUpdate.HDIIdDelAsesor__c);
                siniestro.HDIEmail_Asesor__c = (String)valueJSON(sinWrapp.emailAsesor, sinUpdate.HDIEmail_Asesor__c);
                siniestro.HDITelefonoAsesor__c = (String)valueJSON(sinWrapp.telefonoAsesor, sinUpdate.HDITelefonoAsesor__c);

                siniestro.HDIFechaHoraDeAsignacion__c = timeGMT(sinWrapp.fechaAsignacionLiquidador, sinUpdate.HDIFechaHoraDeAsignacion__c);
                siniestro.HDIFechaHoraDeAsignacionAsesor__c = timeGMT(sinWrapp.fechaAsignacionAsesor, sinUpdate.HDIFechaHoraDeAsignacionAsesor__c);
                siniestro.HDIFechaHoraDeAsignacionEjecutivo__c = timeGMT(sinWrapp.fechaAsignacionEjecutivo, sinUpdate.HDIFechaHoraDeAsignacionEjecutivo__c);
                siniestro.HDIFechaHoraDeAsignacionTaller__c = timeGMT(sinWrapp.fechaAsignacionTaller, sinUpdate.HDIFechaHoraDeAsignacionTaller__c);
                if (String.isEmpty(sinUpdate.HDIPrimerTallerAsignado__c)) {
                    siniestro.HDIPrimerTallerAsignado__c = (String)valueJSON(sinWrapp.nombreTaller, sinUpdate.HDI4I_Nombre_del_taller__c);
                }

            } else if(sinWrapp.numeroEvento == EVENTO_REASIGNACION){

                Boolean resetLiquidador = resetFields(sinWrapp.idLiquidador, sinUpdate.HDI4I_ID_del_liquidador__c, sinWrapp.numeroEvento);
                Boolean resetTaller = resetFields(sinWrapp.rutTaller, sinUpdate.HDI4I_Rut_del_taller__c, sinWrapp.numeroEvento);
                Boolean resetEjecutivo = resetFields(sinWrapp.idEjecutivo, sinUpdate.HDIIDEjecutivo__c, sinWrapp.numeroEvento);
                Boolean resetAsesor = resetFields(sinWrapp.idAsesor, sinUpdate.HDIIdDelAsesor__c, sinWrapp.numeroEvento);
                
                if(resetLiquidador){
                    siniestro.HDI4I_ID_del_liquidador__c = sinWrapp.idLiquidador;
                    siniestro.HDITipoDeLiquidador__c = sinWrapp.tipoLiquidador;
                    siniestro.HDIEmail_Liquidador__c = sinWrapp.emailLiquidador;
                    siniestro.HDITelefonoLiquidador__c = sinWrapp.telefonoLiquidador;
                    siniestro.HDI4I_Fecha_reasignacion_liquidador__c = timeGMT(sinWrapp.fechaReasignacionLiquidador, sinUpdate.HDI4I_Fecha_reasignacion_liquidador__c);
                }

                if(resetTaller){
                    siniestro.HDI4I_Rut_del_taller__c = sinWrapp.rutTaller;
                    siniestro.HDIDVDelTaller__c = sinWrapp.dvTaller;
                    siniestro.HDI4I_Nombre_del_taller__c = sinWrapp.nombreTaller;
                    siniestro.HDISucursalDelTaller__c = sinWrapp.sucursalTaller;
                    siniestro.HDIDireccionDelTaller__c = sinWrapp.direccionTaller;
                    siniestro.HDINumeroDeContactoDelTaller__c = sinWrapp.telefonoTaller;
                    siniestro.HDIEmailDelTaller__c = sinWrapp.emailTaller;
                    siniestro.HDITipo_de_Servicio_Taller__c = sinWrapp.tipoServicioTaller;
                    siniestro.HDI4I_Fecha_de_reasignacion_de_taller__c = timeGMT(sinWrapp.fechaReasignacionTaller, sinUpdate.HDI4I_Fecha_de_reasignacion_de_taller__c);
                }

                if(resetEjecutivo){
                    siniestro.HDIIDEjecutivo__c = sinWrapp.idEjecutivo;
                    siniestro.HDIEmail_Ejecutivo__c = sinWrapp.emailEjecutivo;
                    siniestro.HDITelefono_Ejecutivo__c = sinWrapp.telefonoEjecutivo;
                    siniestro.HDIFechaReasignacionEjecutivo__c = timeGMT(sinWrapp.fechaReasignacionEjecutivo, sinUpdate.HDIFechaReasignacionEjecutivo__c);
                }

                if(resetAsesor){
                    siniestro.HDIIdDelAsesor__c = sinWrapp.idAsesor;
                    siniestro.HDIEmail_Asesor__c = sinWrapp.emailAsesor;
                    siniestro.HDITelefonoAsesor__c = sinWrapp.telefonoAsesor;
                    siniestro.HDIFechaReasignacionAsesor__c = timeGMT(sinWrapp.fechaReasignacionAsesor, sinUpdate.HDIFechaReasignacionAsesor__c);
                }
 
            }

            if (mapUser.containsKey(sinWrapp.idAsesor)){
                siniestro.HDI4i_Agente_asignado__c = mapUser.get(sinWrapp.idAsesor).Id;
                if (String.isEmpty(sinUpdate.HDIPrimerAsesorAsignado__c) && sinWrapp.numeroEvento == EVENTO_ASIGNACION) {
                    siniestro.HDIPrimerAsesorAsignado__c = mapUser.get(sinWrapp.idAsesor).Name;
                }
            } 
            if(mapUser.containsKey(sinWrapp.idLiquidador)){
                siniestro.SIN_Liquidador__c = mapUser.get(sinWrapp.idLiquidador).Id;
                if (String.isEmpty(sinUpdate.HDIPrimerLiquidadorAsignado__c) && sinWrapp.numeroEvento == EVENTO_ASIGNACION) {
                    siniestro.HDIPrimerLiquidadorAsignado__c = mapUser.get(sinWrapp.idLiquidador).Name;
                }
            }
            if(mapUser.containsKey(sinWrapp.idEjecutivo)){
                siniestro.OwnerId = mapUser.get(sinWrapp.idEjecutivo).Id;
                if (String.isEmpty(sinUpdate.HDIPrimerEjecutivoAsignado__c) && sinWrapp.numeroEvento == EVENTO_ASIGNACION) {
                    siniestro.HDIPrimerEjecutivoAsignado__c = mapUser.get(sinWrapp.idEjecutivo).Name;
                } 
            }

        }

        return siniestro;
    }

    private Object valueJSON(Object value, Object valueField) {
        if (value != '' && value != null) {
            return value;
        }
        return valueField;
    }

    private Datetime timeGMT(Datetime timeJSON, Datetime timeField){

        Datetime dtFinal;
        Datetime varHora;
        Integer yearLimit = 1930;
        

        if (timeJSON != null && timeJSON.year() >= yearLimit) {

            String hourZoneString = String.valueOf(TZ.getOffset(timeJSON)/3600000);
            Integer hourZone = hourZoneString.contains('-') ? Integer.valueOf(hourZoneString.replace('-','+')) : Integer.valueOf(hourZoneString.replace('+','-'));
            varHora = timeJSON.addHours(hourZone);

            dtFinal = varHora;

        } else {
            dtFinal = timeField;
        }

        return dtFinal;
    }

    private Boolean resetFields(String valueJSON, String valueField, String nroEvento){

        Boolean reset = false;

        if (!String.isEmpty(valueJSON) && !valueJSON.equalsIgnoreCase(valueField) && nroEvento == EVENTO_REASIGNACION) {
            reset = true;
        }

        return reset;
    }

    public String checkEmail(String email) {
        String res = null;
        if (email != null && email.length() > 0) {
            String emailRegex = '^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$';
            Pattern MyPattern = Pattern.compile(emailRegex);
            Matcher MyMatcher = MyPattern.matcher(email);
    
            if (MyMatcher.matches()) {
                res = email;
            }
        }
        return res;
    }

}