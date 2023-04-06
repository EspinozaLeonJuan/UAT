trigger HDI4i_RoundRobinNuevoAgente on HDI4i_Agente_en_cola_round_robin__c (before insert) {
    List <HDI4i_Agente_en_cola_round_robin__c> agente = new List <HDI4i_Agente_en_cola_round_robin__c>();
    if(trigger.isDelete) {
        agente = Trigger.old;
    } else {
        agente = Trigger.new;
    }
    for(HDI4i_Agente_en_cola_round_robin__c ag : agente){
        Integer nAgentes = [SELECT Count() FROM HDI4i_Agente_en_cola_round_robin__c WHERE HDI4i_Cola_round_robin__c =: ag.HDI4i_Cola_round_robin__c];
        System.debug('DEBUG -- Count() FROM HDI4i_Agente__c = '+nAgentes);
        HDI4i_Cola_round_robin__c colaAfectada = [SELECT Id, HDI4i_N_mero_de_agentes__c FROM HDI4i_Cola_round_robin__c WHERE Id =: ag.HDI4i_Cola_round_robin__c ];
        if(trigger.isDelete) { nAgentes--; } else { nAgentes++; }
        colaAfectada.HDI4i_N_mero_de_agentes__c = nAgentes;
        update colaAfectada;
    }
}