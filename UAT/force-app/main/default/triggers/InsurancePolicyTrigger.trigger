trigger InsurancePolicyTrigger on InsurancePolicy (before insert, before update, after update) {
    
    if(Trigger.isUpdate && Trigger.isAfter){
        if(EnviarCorreo.nuevaPoliza(Trigger.old, Trigger.new)){
            //EnviarCorreo.Polizas(Trigger.new);
            for(InsurancePolicy i: Trigger.new){
                if(EnviarCorreo.firmaOppo(i.SourceOpportunityId)){
                    HDI4I_Crono_Email.crono(i.Id, 'po');
                }else{
                    system.debug('falló firma');
                }                
            }
        }
        
    }

}