public with sharing class BECS_Modelo extends fflib_SObjectDomain{
    private static final List<Schema.SObjectType> SERVICE_SOBJECTS = new Schema.SObjectType[] { HDI4I_Modelo__c.SObjectType };

    public BECS_Modelo(List<HDI4I_Modelo__c> sObjectList) {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new BECS_Modelo(sObjectList);
        }
    }
    public Map<String, HDI4I_Modelo__c> crearModelos(Map<String, String> modelosNameByCodModelo, Map<String, String> marcaCodByCodModelo){
        BECS_ModeloSelector selector = new BECS_ModeloSelector();
        Map<String, HDI4I_Marca__c> marcasByCod = new BECS_MarcaSelector().selectByCodMarca(new Set<String>(marcaCodByCodModelo.values()));
        Map<String, HDI4I_Modelo__c> modelosByCod = selector.selectByCodModelo(modelosNameByCodModelo.keySet());
        List<HDI4I_Modelo__c> modelosToCreate = new List<HDI4I_Modelo__c>();
        for(String codModelo : modelosNameByCodModelo.keySet())
        {
            system.debug('codModelo ' + codModelo);
            system.debug('modelosByCod ' + modelosByCod);
            if(!modelosByCod.containsKey(codModelo) && marcasByCod.containsKey(marcaCodByCodModelo.get(codModelo)))
            {
                HDI4I_Modelo__c modelo = new HDI4I_Modelo__c(name=modelosNameByCodModelo.get(codModelo),HDI4I_Codigo_del_modelo__c=codModelo, HDI4I_Marca__c = marcasByCod.get(marcaCodByCodModelo.get(codModelo)).Id);
                modelosToCreate.add(modelo);
            }
        }
        if(!modelosToCreate.isEmpty())
        {
            insert modelosToCreate;
            return selector.selectByCodModelo(modelosNameByCodModelo.keySet());
        }
        return modelosByCod;
    }
}