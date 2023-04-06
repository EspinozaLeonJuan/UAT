global class Crono implements Schedulable {
    /*
ejecución de cronómetro extrallendo el nombre de la tarea programada para encontrar Id de la oportunidad
*/
    
    private string web = '';
    global void execute(SchedulableContext ctx) {        
        
        //Extracción de nombre
        string idCtx = ctx.getTriggerId();
        CronTrigger cron = new CronTrigger();
        cron = [Select cronjobdetailid  from CronTrigger where id =: idCtx];
        system.debug(cron.CronJobDetailId);
        CronJobDetail cronD = new CronJobDetail();
        cronD = [Select name from CronJobDetail where id =: cron.CronJobDetailId];        
        string idOportunidadWebStr = nombre(cronD.name);
        string hora = cronD.name.right(12);
        system.debug('el id de la oportunidad es: '+ idOportunidadWebStr+' '+hora);
        
        
        // Búsqueda de oportunidad
        Lead pro = new Lead();
        Opportunity opo = new Opportunity();
        String h = string.valueOf(system.now().hour());
        String m = string.valueOf(system.now().minute());
        String mm = string.valueOf(system.now().millisecond());
        system.debug(h);
        system.debug(m);
        system.debug(mm);        
        
        if(opoExiste(idOportunidadWebStr, hora)){
            opo = [select HDI4I_Id_Oportunidad_web__c, HDI4I_Paso_cotizacion_web__c, HDI4I_Oportunidad_asignada__c, HDI4I_Debe_asignar__c, owner.name, HDI4I_Round_Robin__c, CreatedById from Opportunity 
                   where HDI4I_Id_Oportunidad_web__c =: idOportunidadWebStr and HDI4I_Hora_cronometro__c =: hora]; 
            
            
            
            
            system.debug('lo que llega despues es: ' + opo.HDI4I_Id_Oportunidad_web__c +' '+opo.HDI4I_Paso_cotizacion_web__c+' '+opo.HDI4I_Debe_asignar__c+' '+opo.Owner.name+' '+opo.HDI4I_Round_Robin__c+' '+opo.CreatedById);
            pro.firstname = 'ModificadoCrono';
            
            if(opo.HDI4I_Oportunidad_asignada__c  == false && opo.HDI4I_Paso_cotizacion_web__c == 'Elegir'){
                opo.HDI4I_Debe_asignar__c = true;            
                try{
                    update opo;
                    system.debug('Asignó en paso Elegir');
                }catch(DmlException e){
                    system.debug(e.getMessage());
                }
                
            } else if(opo.HDI4I_Oportunidad_asignada__c  == false && opo.HDI4I_Paso_cotizacion_web__c == 'Contratar'){
                opo.HDI4I_Debe_asignar__c = true;
                try{
                    update opo;
                    system.debug('Asignó en paso Contratar');
                }catch(DmlException e){
                    system.debug(e.getMessage());
                }  
                
            } else if(opo.HDI4I_Oportunidad_asignada__c  == false && opo.HDI4I_Paso_cotizacion_web__c == 'Cotizar'){
                opo.HDI4I_Debe_asignar__c = true;
                try{
                    update opo;
                    system.debug('Asignó en paso Cotizar');
                }catch(DmlException e){
                    system.debug(e.getMessage());
                } 
            }
            
            //update opo;
            
            
            system.debug('lo que modifica después es: ' + opo.HDI4I_Id_Oportunidad_web__c +' '+opo.HDI4I_Paso_cotizacion_web__c+' '+opo.HDI4I_Debe_asignar__c);
        }
    }
    
    public String nombre(String n){
        string r = '';
        integer l = integer.valueOf(n.length()-12);
        r = n.left(l);
        
        return r;
    } 
    public static boolean opoExiste(string n, string h){
        system.debug(h);
        system.debug(n);
        integer e = [select count() from opportunity where HDI4I_Hora_cronometro__c =: h and HDI4I_Id_Oportunidad_web__c =: n];
        /*opportunity opp = [select HDI4I_Hora_cronometro__c, HDI4I_Id_Oportunidad_web__c from opportunity where HDI4I_Hora_cronometro__c =: h and HDI4I_Id_Oportunidad_web__c =: n];
        system.debug(opp.HDI4I_Hora_cronometro__c);
        system.debug(opp.HDI4I_Id_Oportunidad_web__c);*/
        if(e>0){
            return true;
        }else{
            return false;
        }
    }
}