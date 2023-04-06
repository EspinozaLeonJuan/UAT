trigger QuoteTrigger on Quote (before insert, before update, after update) {
    system.debug('holiholi');
    if(Trigger.isUpdate && Trigger.isAfter){
        if(EnviarCorreo.nuevaCotizacion(Trigger.old, Trigger.new)){
            //EnviarCorreo.Cotizaciones(Trigger.new);
            system.debug('enviar correo');
            for(Quote q: Trigger.new){
                if(EnviarCorreo.firmaOppo(q.OpportunityId)){
                    HDI4I_Crono_Email.crono(q.Id, 'co');
                }else{
                    system.debug('falló firma');
                }
            }
        }
        
    }
    
    
    
}