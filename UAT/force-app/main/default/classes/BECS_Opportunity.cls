public with sharing class BECS_Opportunity extends fflib_SObjectDomain{
    private static final List<Schema.SObjectType> SERVICE_SOBJECTS = new Schema.SObjectType[] { Opportunity.SObjectType };
        
    public BECS_Opportunity(List<Opportunity> sObjectList) {
		super(sObjectList);
    }

    public override void onBeforeInsert() {   
        Map<String, String> marcasNameByCod = new Map<String, String>();
        Map<String, String> modelosNameByCodModelo = new Map<String, String>();
        Map<String, String> marcaCodByCodModelo = new Map<String, String>();
        Set<String> setCampanas = new Set<String>();

        for(Opportunity opp :  (List<Opportunity>) Records){      
            system.debug(opp.HDI4I_Id_Marca_vehiculo__c);
            System.debug('opp.LeadSource ' + opp.LeadSource + opp.HDI4I_Marca_objeto__c + opp.HDI4I_Modelo_objeto__c);
            if(opp.HDI4I_Origen_de_la_oportunidad__c == 'VSV2' && opp.HDI4I_Marca_objeto__c == null && opp.HDI4I_Modelo_objeto__c == null)
            {
                marcasNameByCod.put(opp.HDI4I_Id_Marca_vehiculo__c, opp.HDI4I_Marca__c);
                modelosNameByCodModelo.put(opp.HDI4I_Id_Modelo_vehiculo__c, opp.HDI4I_Modelo__c); 
                marcaCodByCodModelo.put(opp.HDI4I_Id_Modelo_vehiculo__c, opp.HDI4I_Id_Marca_vehiculo__c);
            }
            setCampanas.add(opp.CampaignId);
        }
        //crea las marcas que no existen y recupera todas por codigo de marca
        BECS_Marca createMarcas = new BECS_Marca(new List<HDI4I_Marca__c>());
        Map<String, HDI4I_Marca__c> marcasByCod = createMarcas.crearMarcas(marcasNameByCod);
         system.debug(marcasByCod);      
        //crea los modelos que no existen y recupera todos los modelos por codigo modelo
        BECS_Modelo createModelos = new BECS_Modelo(new List<HDI4I_Modelo__c>());
        Map<String, HDI4I_Modelo__c> modelosByCod = createModelos.crearModelos(modelosNameByCodModelo, marcaCodByCodModelo);
        
        system.debug(marcasByCod);      
        system.debug(modelosByCod);

        Map<String, Campaign> mapCampanas = new BECS_CampanaSelector().selectById(setCampanas);
        
        for(Opportunity opp :  (List<Opportunity>) Records){ 
            system.debug(opp.HDI4I_Id_Marca_vehiculo__c);      
            system.debug(opp.HDI4I_Id_Modelo_vehiculo__c);
            if(opp.HDI4I_Origen_de_la_oportunidad__c == 'VSV2' && opp.HDI4I_Marca_objeto__c == null && opp.HDI4I_Modelo_objeto__c == null &&
               marcasByCod.containsKey(opp.HDI4I_Id_Marca_vehiculo__c) && modelosByCod.containsKey(opp.HDI4I_Id_Modelo_vehiculo__c))
            {
                //asigna las marcas y modelos a la Opportunity
                opp.HDI4I_Marca_objeto__c = marcasByCod.get(opp.HDI4I_Id_Marca_vehiculo__c).Id;
                opp.HDI4I_Modelo_objeto__c = modelosByCod.get(opp.HDI4I_Id_Modelo_vehiculo__c).Id;
            }
            if (mapCampanas.containsKey(opp.CampaignId)){
                opp.HDI4I_Campana_cotizador_web__c = mapCampanas.get(opp.CampaignId).Name;
            }
        }        
    }

    public override void onBeforeUpdate(Map<Id, SObject> sObjectMap) {
        Map<Id, Opportunity> oldOppMap = (Map<Id, Opportunity>)Trigger.oldMap;
        Set<String> setCampanas = new Set<String>();
        Set<String> setOwners = new Set<String>();
        Set<Opportunity> setOppsOwnersChanged = new Set<Opportunity>();

        for(Opportunity opp :  (List<Opportunity>) Records){ 
            if(opp.isClosed && opp.IsClosed != oldOppMap.get(opp.id).isClosed){
                opp.HDI4I_Id_Oportunidad_web__c = opp.HDI4I_Id_Oportunidad_web__c + string.valueOf(system.now());
            }
            if(opp.CampaignId != oldOppMap.get(opp.id).CampaignId){
                setCampanas.add(opp.CampaignId);
            }
            if(opp.OwnerId != oldOppMap.get(opp.id).OwnerId){
                setOwners.add(opp.OwnerId);
                setOppsOwnersChanged.add(opp);
            }      
        }    
        
        if (!setOwners.isEmpty()) {
            Map<Id, User> mapUsers = new Map<Id, User>([Select MobilePhone,Email,HDIR4I_Firma__c FROM User where id IN: setOwners]);
            for(Opportunity opo :  setOppsOwnersChanged){
                User usuario = mapUsers.get(opo.ownerId);
                opo.HDI4I_Firma__c = usuario.HDIR4I_Firma__c;
                opo.HDI4I_TelEjecutiva__c = usuario.MobilePhone;
                opo.HDI4I_EmailEjecutiva__c = usuario.Email;
            }
        
        }
        
        if (!setCampanas.isEmpty()) {
            Map<String, Campaign> mapCampanas = new BECS_CampanaSelector().selectById(setCampanas);    
            for(Opportunity opp :  (List<Opportunity>) Records){
                if (mapCampanas.containsKey(opp.CampaignId)){
                    opp.HDI4I_Campana_cotizador_web__c = mapCampanas.get(opp.CampaignId).Name;
                }    
            }
        }
    }

    public override void onAfterUpdate(Map<Id, SObject> sObjectMap) {} 
    
}