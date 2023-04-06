public with sharing class BECS_CampanaSelector extends fflib_SObjectSelector{
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Campaign.Id,
            Campaign.Name,
            Campaign.BECS_DiasCierreOportunidad__c,
            Campaign.BECS_IdCampanaCotizadorWeb__c};
    }
    
    public Schema.SObjectType getSObjectType() {
        return Campaign.sObjectType;
    }
    
    public Map<String, Campaign> selectByIdCampanaCotizadorWeb(Set<String> setIdCampanaCotizadorWeb) {
        Map<String, Campaign> mapCampanas = new Map<String, Campaign>();

        for(Campaign item : Database.query(newQueryFactory().setCondition('BECS_IdCampanaCotizadorWeb__c IN: setIdCampanaCotizadorWeb').toSOQL()))
        {
            mapCampanas.put(item.BECS_IdCampanaCotizadorWeb__c, item);
        }
        
        return mapCampanas;
    }

    public Map<String, Campaign> selectById(Set<String> setIdCampanaCotizadorWeb) {
        Map<String, Campaign> mapCampanas = new Map<String, Campaign>();

        for(Campaign item : Database.query(newQueryFactory().setCondition('ID IN: setIdCampanaCotizadorWeb').toSOQL()))
        {
            mapCampanas.put(item.Id, item);
        }
        
        return mapCampanas;
    }
}