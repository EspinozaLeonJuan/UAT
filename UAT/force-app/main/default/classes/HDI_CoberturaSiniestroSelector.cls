/**********************************************************************
 Name:  HDI_CoberturaSiniestroSelector()
 Copyright © 2021  INETUM
 ======================================================
======================================================
Purpose:                                                            
Cobertura del Siniestro Selector Handle SOQL for HDI4I_Cobertura_del_siniestro__c                                                           
======================================================
======================================================
History                                                            
-------                                                            
VERSION  AUTHOR            DATE              DETAIL            Description
   1.0   Fran Oseguera   19/10/2021      INITIAL DEVELOPMENT    CSR: 
***********************************************************************/
public with sharing class HDI_CoberturaSiniestroSelector extends fflib_SObjectSelector{
    
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            HDI4I_Cobertura_del_siniestro__c.Id,
            HDI4I_Cobertura_del_siniestro__c.HDI4I_Provision__c,
            HDI4I_Cobertura_del_siniestro__c.HDI4I_Deducible__c,
            HDI4I_Cobertura_del_siniestro__c.HDI4I_Fecha_de_evaluacion_taller__c,
            HDI4I_Cobertura_del_siniestro__c.HDI4I_Fecha_de_rechazo__c,
            HDI4I_Cobertura_del_siniestro__c.HDI4I_Fecha_reasignacion_taller__c,
            HDI4I_Cobertura_del_siniestro__c.HDI4I_Fecha_reasignacion_liquidador__c,
            HDI4I_Cobertura_del_siniestro__c.HDI4I_Id_del_liquidador__c,
            HDI4I_Cobertura_del_siniestro__c.HDI4I_Nombre_del_liquidador__c,
            HDI4I_Cobertura_del_siniestro__c.HDI4I_Nombre_taller__c,
            HDI4I_Cobertura_del_siniestro__c.HDI4I_Rut_taller__c
        };
    }

    public Schema.SObjectType getSObjectType() {
        return HDI4I_Cobertura_del_siniestro__c.sObjectType;
    }

    public List<HDI4I_Cobertura_del_siniestro__c> selectBySiniestroAndCobertura(String numSiniestro, String cobertura) {
        return (List<HDI4I_Cobertura_del_siniestro__c>) Database.query(
            newQueryFactory().
            setCondition('HDI4I_Siniestro__c =: numSiniestro AND HDI4I_Id_de_cobertura__c =: cobertura').
            toSOQL()
        );
    }

    public List<HDI4I_Cobertura_del_siniestro__c> selectBySiniestro(String numSiniestro) {
        return (List<HDI4I_Cobertura_del_siniestro__c>) Database.query(
            newQueryFactory().
            setCondition('HDI4I_Siniestro__c =: numSiniestro').
            toSOQL()
        );
    }

}