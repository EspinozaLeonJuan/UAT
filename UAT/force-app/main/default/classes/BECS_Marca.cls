public with sharing class BECS_Marca extends fflib_SObjectDomain{
    private static final List<Schema.SObjectType> SERVICE_SOBJECTS = new Schema.SObjectType[] { HDI4I_Marca__c.SObjectType };

    public BECS_Marca(List<HDI4I_Marca__c> sObjectList) {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new BECS_Marca(sObjectList);
        }
    }
    public Map<String, HDI4I_Marca__c> crearMarcas(Map<String, String> marcasNameByCod){
        BECS_MarcaSelector selector = new BECS_MarcaSelector();
        Map<String, HDI4I_Marca__c> marcasByCod = selector.selectByCodMarca(marcasNameByCod.keySet());
        List<HDI4I_Marca__c> marcasToCreate = new List<HDI4I_Marca__c>();
        for(String codMarca : marcasNameByCod.keySet())
        {
            if(!marcasByCod.containsKey(codMarca))
            {
                HDI4I_Marca__c marca = new HDI4I_Marca__c(name=marcasNameByCod.get(codMarca), HDI4I_Codigo_de_la_marca__c = codMarca);
                marcasToCreate.add(marca);
            }
        }
        if(!marcasToCreate.isEmpty())
        {
            insert marcasToCreate;
            return selector.selectByCodMarca(marcasNameByCod.keySet());
        }
        return marcasByCod;
    }
}