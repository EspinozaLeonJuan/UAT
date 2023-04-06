public class BECS_MarcaSelector extends fflib_SObjectSelector{
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            	HDI4I_Marca__c.Id,
                HDI4I_Marca__c.Name,
                HDI4I_Marca__c.HDI4I_Codigo_de_la_marca__c};
    }
    
    public Schema.SObjectType getSObjectType() {
        return HDI4I_Marca__c.sObjectType;
    }
    
     public Map<String, HDI4I_Marca__c> selectByCodMarca(Set<String> idMarca) {
        Map<String, HDI4I_Marca__c> modelosByCodMarca = new Map<String, HDI4I_Marca__c>();
        for(HDI4I_Marca__c marca : Database.query(newQueryFactory().setCondition('HDI4I_Codigo_de_la_marca__c =: idMarca').toSOQL()))
        {
            modelosByCodMarca.put(marca.HDI4I_Codigo_de_la_marca__c, marca);
        }
        return modelosByCodMarca;
    }    
}