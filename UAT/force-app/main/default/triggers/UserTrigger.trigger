trigger UserTrigger on User (before insert, before update) {
    
    if(Trigger.isUpdate && Trigger.isBefore){
        system.debug('hola');
        if(metodos.cambio(trigger.old, Trigger.new)){
            system.debug('metodos.cambio');
            //metodos.correo(trigger.new);
        }
    }

}