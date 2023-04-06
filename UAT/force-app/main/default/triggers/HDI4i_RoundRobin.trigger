trigger HDI4i_RoundRobin on Case (before insert) {
    Integer i = 0;
    Integer actual = 0;
    Integer proximo = 0;
    Boolean ultimo = false;
    Boolean asignacionHecha = false;
    Id agenteActual = null;
    Id idTRCaseSiniestro = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Siniestro').getRecordTypeId();
    
    for(Case esteCaso : Trigger.new){
        if(esteCaso.recordTypeId != idTRCaseSiniestro){
        //El caso NO ha sido asignado vía RR (este trigger)
        //Por lo tanto, tengo que asignarlo
        Database.DMLOptions options = new Database.DMLOptions();
        options.assignmentRuleHeader.useDefaultRule = true;
        esteCaso.setOptions(options);
        List<HDI4i_Cola_round_robin__c> colas = [SELECT Id, Name, HDI4i_N_mero_de_agentes__c FROM HDI4i_Cola_round_robin__c WHERE HDI4i_Tipificaci_n_de_caso__c =: esteCaso.Reason];
        System.debug('DEBUG: '+colas);
        if (colas.size()>0){
            //2. Existe una cola para este caso
            //   Obtener la lista de usuarios
            //   Para determinar quién es el agente actualmente asignado
            /*
            Database.DMLOptions options = new Database.DMLOptions();
            options.assignmentRuleHeader.useDefaultRule = false;
            esteCaso.setOptions(options);
            */
            for(HDI4i_Cola_round_robin__c cola : colas){
                List<HDI4i_Agente_en_cola_round_robin__c> agentes = [SELECT HDI4i_Usuario__c, HDI4i_Asignado_actual__c FROM HDI4i_Agente_en_cola_round_robin__c WHERE HDI4i_Cola_round_robin__c =: cola.Id ORDER BY HDI4i_Usuario__c];
                for(HDI4i_Agente_en_cola_round_robin__c ag : agentes){
                    //CIRCUITO #1
                    //ESTABLECER VARIABLES
                    //actual  (ESTABLECE EL EJECUTIVO ACTUAL; SI actual == 0 LA COLA NO TIENE ASIGNADOS AÚN)
                    //proximo (ESTABLECE EL EJECUTIVO QUE SERÁ ASGINADO; SI actual == 0 -> proximo = 1)
                    //ultimo  (DETERMINA SI EL ÚLTIMO EJECUTIVO ES EL ACTUAL ASIGNADO)
                    i++;
                    System.debug('DEBUG i: '+i+' -- ESTADO DE VARIABLES actual = '+actual+', proximo = '+proximo+', ultimo = '+ultimo);
                    if(ag.HDI4i_Asignado_actual__c){
                        //Hemos encontrado al ejecutivo actualmente asignado
                        //Asignamos el próximo como el siguiente de la lista
                        actual = i;
                        proximo = actual + 1;
                        System.debug('DEBUG: encontramos al asignado: '+ag.HDI4i_Usuario__c);
                        System.debug('DEBUG i: '+i+' -- ESTADO DE VARIABLES actual = '+actual+', proximo = '+proximo+', ultimo = '+ultimo);
                    }
                    if(i == cola.HDI4i_N_mero_de_agentes__c && ag.HDI4i_Asignado_actual__c){
                        //Es el último de la cola
                        //proximo ahora es 1
                        ultimo = true;
                        proximo = 1;
                        System.debug('DEBUG: en efecto, el asignado era el último de la lista');
                        System.debug('DEBUG i: '+i+' -- ESTADO DE VARIABLES actual = '+actual+', proximo = '+proximo+', ultimo = '+ultimo);
                    }
                }
                //si no hay ejecutivo asignado, proximo es el primero
                if(actual == 0) proximo = 1;
                i = 0;
                System.debug('DEBUG: SEGUNDO LOOP');
                for(HDI4i_Agente_en_cola_round_robin__c agente : agentes){
                    //CIRCUITO #2
                    //DEFINIR EL EJECUTIVO ASIGNADO
                    //El ejecutivo asignado es 'proximo'
                    i++;
                    if(i == proximo) {
                        esteCaso.HDI4i_Agente_asignado__c = agente.HDI4i_Usuario__c;
                        System.debug('DEBUG: se ha asignado al ejecutivo '+agente.HDI4i_Usuario__c+' al caso');
                    }
                }
                i = 0;
                for(HDI4i_Agente_en_cola_round_robin__c agente : agentes){
                    //CIRCUITO #3
                    //CAMBIAR EL ASIGNADO ACTUAL (YA ASIGNADO)
                    i++;
                    if(i == actual) {
                        agente.HDI4i_Asignado_actual__c = false;
                        System.debug('DEBUG: asignado actual ('+agente.HDI4i_Asignado_actual__c+') es removido');
                        update agente;
                    }
                    if(i == proximo) {
                        agente.HDI4i_Asignado_actual__c = true;
                        System.debug('DEBUG: asignado actual ('+agente.HDI4i_Asignado_actual__c+') es removido');
                        update agente;
                    }
                }
            }            
        }
        }
    }
}