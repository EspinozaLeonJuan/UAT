/**********************************************************************
 Name:  HDI_CaseSelector()
 Copyright © 2021  INETUM
 ======================================================
======================================================
Purpose:                                                            
Cases Selector Handle SOQL for Case                                                          
======================================================
======================================================
History                                                            
-------                                                            
VERSION  AUTHOR            DATE              DETAIL            Description
   1.0   Fran Oseguera   19/10/2021      INITIAL DEVELOPMENT    CSR: 
   1.1   Jeff Velasquez  07/03/2023      SINIESTROS SIN         New method for getting the list of cases     
***********************************************************************/
public with sharing class HDI_CaseSelector extends fflib_SObjectSelector{
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Case.Id,
            Case.HDI4I_ID_del_denuncio__c,
            Case.HDI4I_Fecha_de_recepcion_del_vehiculo__c,
            Case.HDI4I_Deducible_inteligente__c,
            Case.HDI4I_Fecha_actualiza_deduc_inteligente__c,
            Case.HDI4I_Estado_del_denuncio__c,
            Case.HDI4I_ID_del_liquidador__c,
            Case.HDI4I_Nombre_del_liquidador__c,
            Case.RecordTypeId,
            Case.HDI4I_Rut_del_taller__c,
            Case.HDI4I_Nombre_del_taller__c,
            Case.HDI4I_Fecha_de_generacion_finiquito__c,
            Case.HDI4I_N_Siniestro__c,
            Case.HDIFechaHoraDeAsignacion__c,
            Case.HDIFechaCitacion__c,
            Case.HDITipoDeLiquidador__c,
            Case.HDIEmail_Liquidador__c,
            Case.HDITelefonoLiquidador__c,
            Case.HDIDVDelTaller__c,
            Case.HDISucursalDelTaller__c,
            Case.HDIDireccionDelTaller__c,
            Case.HDINumeroDeContactoDelTaller__c,
            Case.HDIEmailDelTaller__c,
            Case.HDIIDEjecutivo__c,
            Case.HDIEmail_Ejecutivo__c,
            Case.HDITelefono_Ejecutivo__c,
            Case.HDIIdDelAsesor__c,
            Case.HDIEmail_Asesor__c,
            Case.HDITelefonoAsesor__c,
            Case.HDIFechaHoraDeAsignacionAsesor__c,
            Case.HDIFechaHoraDeAsignacionEjecutivo__c,
            Case.HDIFechaHoraDeAsignacionTaller__c,
            Case.HDI4I_Fecha_reasignacion_liquidador__c,
            Case.HDIFechaReasignacionAsesor__c,
            Case.HDIFechaReasignacionEjecutivo__c,
            Case.HDI4I_Fecha_de_reasignacion_de_taller__c,
            Case.HDIPrimerTallerAsignado__c,
            Case.HDIFecha_actualizacion_email_Asesor__c,
            Case.HDIFecha_actualizacion_contacto_Asesor__c,
            Case.HDIFecha_actualizacion_email_Ejecutivo__c,
            Case.HDIFecha_actualizacion_contacto_Ejecutiv__c,
            Case.HDIFecha_actualizacion_contacto_Taller__c,
            Case.HDIFecha_actualizacion_email_Taller__c,
            Case.HDITipo_de_Servicio_Taller__c,
            Case.HDIPrimerAsesorAsignado__c,
            Case.HDIPrimerLiquidadorAsignado__c,
            Case.HDIPrimerEjecutivoAsignado__c,
            Case.Status,
            Case.ownerId
        };
    }

    public Schema.SObjectType getSObjectType() {
        return Case.sObjectType;
    }
    
    public List<Case> selectByNumSiniestro(String numSiniestro) {
        return (List<Case>) Database.query(
            newQueryFactory().
            setCondition('HDI4I_N_Siniestro__c =: numSiniestro').
            toSOQL()
        );
    }
    
    public List<Case> selectByNumSiniestro(Set<Id> numSiniestro) {
        return (List<Case>) Database.query(
            newQueryFactory().
            setCondition('HDI4I_N_Siniestro__c IN: numSiniestro').
            toSOQL()
        );
    }
    public List<Case> selectCaseWithTerceros(Set<String> numSiniestros){
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('HDI4I_N_Siniestro__c IN :numSiniestros');
   
        new HDI_TercerosSelector().
              addQueryFactorySubselect(query,'terceros__r');
        system.debug('query ' +query );
        return Database.query(query.toSOQL());

     }

}