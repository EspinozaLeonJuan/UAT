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
            Case.HDI4I_Fecha_de_reasignacion_de_taller__c,
            Case.HDI4I_Fecha_reasignacion_liquidador__c,
            Case.HDI4I_Rut_del_taller__c,
            Case.HDI4I_Nombre_del_taller__c,
            Case.HDI4I_Fecha_de_generacion_finiquito__c,
            Case.HDI4I_N_Siniestro__c,
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

    public List<Case> selectByNumSin(Set<String> numSiniestro) {
        return (List<Case>) Database.query(
            newQueryFactory().
            setCondition('HDI4I_N_Siniestro__c IN: numSiniestro').
            toSOQL()
        );
    }

}