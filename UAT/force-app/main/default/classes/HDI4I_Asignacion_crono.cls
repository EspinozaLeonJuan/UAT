global class HDI4I_Asignacion_crono implements Schedulable{
    
    global void execute(SchedulableContext ctx){
        HDI4I_RoundRobin_Crono.buildDataAsignacion(false);
        asig();
    }
    
    public static string asig(){
        List<HDI4I_Estado_ejecutivas_call_center__c> ejeOn = [SELECT Id, HDI4I_Nombre_completo_ejecutiva__c, HDI4I_Asignacion__c, HDI4I_Ejecutiva__c, HDI4I_Cantidad__c , HDI4I_Porcentaje_asignacion__c 
                                                              FROM HDI4I_Estado_ejecutivas_call_center__c where HDI4I_On_Off__c = true order by HDI4I_Cantidad__c];
        system.debug('asig(): '+ejeOn.size());
        if(ejeOn.size() != 0){
            for(HDI4I_Estado_ejecutivas_call_center__c r: ejeOn){
                r.HDI4I_Asignacion__c = false;
            }            
            ejeOn[0].HDI4I_Asignacion__c = true;
            update ejeOn;            
        }
        return '';
    }
    
}