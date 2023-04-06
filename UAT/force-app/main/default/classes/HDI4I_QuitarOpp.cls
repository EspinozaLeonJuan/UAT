global class HDI4I_QuitarOpp implements Schedulable{
    
    global void execute(SchedulableContext ctx){                
        List <HDI4I_Estado_ejecutivas_call_center__c> e = [SELECT Id, HDI4I_Nombre_completo_ejecutiva__c, HDI4I_Asignacion__c, HDI4I_On_Off__c, HDI4I_Ejecutiva__c, HDI4I_Porcentaje_asignacion__c 
                                                           FROM HDI4I_Estado_ejecutivas_call_center__c  where HDI4I_On_Off__c = false];        
        
        if(e.size() > 0){
            for(HDI4I_Estado_ejecutivas_call_center__c a:e){                
                List<Opportunity> op = [Select id, HDI4I_Fecha_de_asignacion__c, OwnerId, HDI4I_Asignado_Pull__c 
                                        from opportunity where HDI4I_Fecha_de_asignacion__c =: system.now().date() and HDI4I_Asignado_Pull__c =:true and OwnerId =: a.HDI4I_Ejecutiva__c];
                system.debug(op.size());
                for(Opportunity o:op){
                    if(o.OwnerId == a.HDI4I_Ejecutiva__c){
                        system.debug('Se quitará la oportunidad  a '+a.HDI4I_Nombre_completo_ejecutiva__c);
                        o.OwnerId = '0053t000007QVfhAAG';
                        o.HDI4I_Asignado_Pull__c = false;                        
                    }
                }  
                update op;
            }                  
        }else{
            system.debug('Todas las ejecutivas están conectadas');
        }
    }    
}