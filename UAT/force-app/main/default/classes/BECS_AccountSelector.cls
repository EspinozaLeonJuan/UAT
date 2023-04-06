public without sharing class BECS_AccountSelector extends fflib_SObjectSelector{
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Account.Id,
            Account.FirstName,
            Account.LastName,
            Account.HDI4I_RUT_del_cliente__c};
    }
    
    public Schema.SObjectType getSObjectType() {
        return Account.sObjectType;
    }
    
    public Map<String, Account> selectByRUT(Set<String> setRUTs) {
        Map<String, Account> mapClientes = new Map<String, Account>();
        System.debug('setRUTs ' + setRUTs);
        for(Account item : Database.query(newQueryFactory().setCondition('HDI4I_RUT_del_cliente__c =: setRUTs').toSOQL()))
        {
            mapClientes.put(item.HDI4I_RUT_del_cliente__c, item);
        }
        
        return mapClientes;
    }

}