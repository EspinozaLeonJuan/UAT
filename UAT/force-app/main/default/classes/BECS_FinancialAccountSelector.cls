public with sharing class BECS_FinancialAccountSelector extends fflib_SObjectSelector{

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {            
            FinServ__FinancialAccount__c.Id,
            FinServ__FinancialAccount__c.FinServ__FinancialAccountNumber__c,
            FinServ__FinancialAccount__c.BECS_AutodeReemplazo__c,
            FinServ__FinancialAccount__c.BECS_Banco__c,
            FinServ__FinancialAccount__c.BECS_CodigodeProductoElegido__c,
            FinServ__FinancialAccount__c.BECS_Deducible__c,
            FinServ__FinancialAccount__c.BECS_NumerodePoliza__c,
            FinServ__FinancialAccount__c.BECS_Numerodetarjeta__c,
            FinServ__FinancialAccount__c.BECS_PeriododeVigenciadelSeguroCotizado__c,
            FinServ__FinancialAccount__c.BECS_PrimaConlaqueseCotizoSeguro__c,
            FinServ__FinancialAccount__c.BECS_ProductoSeleccionado__c,
            FinServ__FinancialAccount__c.BECS_ResponsabilidadCivil__c,
            FinServ__FinancialAccount__c.BECS_Sucursal__c,
            FinServ__FinancialAccount__c.BECS_SucursalId__c,
            FinServ__FinancialAccount__c.BECS_UltimaPolizaGenerada__c
        };
    }
    
    public Schema.SObjectType getSObjectType() {
        return FinServ__FinancialAccount__c.sObjectType;
    }
    
    public Map<String, FinServ__FinancialAccount__c> selectByNumCuenta(Set<String> setCuentasTarjeta) {
        Map<String, FinServ__FinancialAccount__c> mapResult = new Map<String, FinServ__FinancialAccount__c>();

        for(FinServ__FinancialAccount__c item : Database.query(newQueryFactory().setCondition('BECS_Numerodetarjeta__c IN: setCuentasTarjeta').toSOQL()))
        {
            mapResult.put(item.BECS_Numerodetarjeta__c, item);
        }
        
        return mapResult;
    }

    public List<FinServ__FinancialAccount__c> selectById(Set<Id> listId) {
        fflib_QueryFactory queryFactory = newQueryFactory();
        queryFactory.subselectQuery('FinServ__Opportunities__r').selectField('BECS_BancoEstado__c').selectField('Account.PersonContactId').selectField('Owner.Email').selectField('Account.PersonEmail');
        queryFactory.setCondition('id IN: listId');
        return Database.query( queryFactory.toSOQL() );
    }
}