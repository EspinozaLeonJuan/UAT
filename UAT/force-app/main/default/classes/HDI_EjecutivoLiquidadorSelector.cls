public with sharing class HDI_EjecutivoLiquidadorSelector extends fflib_SObjectSelector{
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            SIN_EjecutivoLiquidador__c.Liquidador__c,
            SIN_EjecutivoLiquidador__c.Id_Liquidador__c,
            SIN_EjecutivoLiquidador__c.Ejecutivo_Siniestro__c
        };
    }

    public Schema.SObjectType getSObjectType() {
        return SIN_EjecutivoLiquidador__c.sObjectType;
    }
    
    public List<SIN_EjecutivoLiquidador__c> byLiquidadorId(String liquidadorIdSet) {
        System.debug('Entra'+liquidadorIdSet);
        return (List<SIN_EjecutivoLiquidador__c>) Database.query(
            newQueryFactory().
            setCondition('Id_Liquidador__c =: liquidadorIdSet').
            toSOQL()
        );
    }
}