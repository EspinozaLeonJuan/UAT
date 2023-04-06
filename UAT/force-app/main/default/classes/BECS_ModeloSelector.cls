public class BECS_ModeloSelector extends fflib_SObjectSelector{
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            	HDI4I_Modelo__c.Id,
                HDI4I_Modelo__c.Name,
                HDI4I_Modelo__c.HDI4I_Codigo_del_modelo__c,
                HDI4I_Modelo__c.HDI4I_Marca__c};
    }
    
    public Schema.SObjectType getSObjectType() {
        return HDI4I_Modelo__c.sObjectType;
    }
    
    public Map<String, HDI4I_Modelo__c> selectByCodModelo(Set<String> idModelo) {
        Map<String, HDI4I_Modelo__c> modelosByCodModelo = new Map<String, HDI4I_Modelo__c>();
        for(HDI4I_Modelo__c modelo : Database.query(newQueryFactory().setCondition('HDI4I_Codigo_del_modelo__c =: idModelo').toSOQL()))
        {
            modelosByCodModelo.put(modelo.HDI4I_Codigo_del_modelo__c, modelo);
        }
        return modelosByCodModelo;
    }
    
}