global class HDI4I_Crono_Email implements Schedulable{
    
    global void execute(SchedulableContext ctx){
        String idCtx = ctx.getTriggerId();
        system.debug(idCtx);
        CronTrigger cron = new CronTrigger();
        cron = [Select CronJobDetailId from CronTrigger where id =: idCtx];
        CronJobDetail cronD = new CronJobDetail();
        cronD = [select Name from CronJobDetail where id =: cron.CronJobDetailId];
        
        String idp = cronD.name;
        
        String idEmail = idE(idp);
        
        system.debug(idp);
        
        System.abortJob(idCtx);
        
        if(idp.left(2) == 'co'){
            
            //List<Quote> q = [select hdi4i_ultima_cotizacion_generada__c, Opportunity.HDI4I_Campana_cotizador_web__c, Email, OpportunityId, name, id, ownerid from Quote where id =: idEmail];
            
            //EnviarCorreo.Cotizaciones(q);
            Set<Id> setQuotesToSend = new Set<Id>();
            setQuotesToSend.add(idEmail); 
            BECS_EmailService.enviarCorreo('Quote', setQuotesToSend);
            
        }else if(idp.left(2) == 'po'){
            
            //List<InsurancePolicy> ip = [select SourceQuoteId, HDI4I_Ultima_poliza_generada__c, SourceOpportunityId, SourceOpportunity.HDI4I_Campana_cotizador_web__c from InsurancePolicy where id =: idEmail];
            
            //EnviarCorreo.Polizas(ip);
            Set<Id> setPolicyToSend = new Set<Id>();
            setPolicyToSend.add(idEmail); 
            BECS_EmailService.enviarCorreo('FinServ__FinancialAccount__c', setPolicyToSend);
            
        }/* else if(idp.left(2) == 'pr'){
            
            List<Opportunity> op = [Select id, HDI4I_Ultima_propuesta_generada__c, HDI4I_Nombres_contratante__c,
                                HDI4I_Marca__c, HDI4I_Modelo__c, HDI4I_Ano_del_vehiculo__c,HDI4I_Campana_cotizador_web__c
                                from Opportunity where id=: idEmail];
            
            EnviarCorreo.Propuestas(op);
        } */
        
    }
    
    public static string crono(String idE, String tipo){
        integer tiempo = 2;
        integer h = integer.valueof(string.valueOf(system.now().hour()));
        integer m = integer.valueof(string.valueOf(system.now().minute()));
        integer s = integer.valueof(string.valueOf(system.now().second()));
        string y = string.valueOf(system.now().year());
        string d = string.valueOf(system.now().day());
        string mes = string.valueOf(system.now().month());
        integer me = m + tiempo;
        integer he = 0;
        integer mf = 0;
        integer r = 0;
        string hes = '';
        string mfs = '';
        string ss = '';
        Integer randomNumber = Integer.valueof((Math.random() * 1000000));
        string rn = string.valueOf(randomNumber);
        if(me >=60){
            he = h + 1;
            r = me - 60;
            mf = r;
            if(mf == 60){
                mf = 0;
            }
        } else {
            he = h;
            mf = me;
        }
        
        if(he < 10){
            hes = '0'+he; 
        } else{
            hes = string.valueOf(he);
        }
        if(mf < 10){
            mfs = '0'+mf; 
        } else{
            mfs = string.valueOf(mf);
        }
        if(s < 10){
            ss = '0'+s; 
        } else{
            ss = string.valueOf(s);
        }
        if(he == 24){
            he = 00;
            hes = string.valueOf(he);
        }
        
        system.debug('se actualiza a las: '+he+':'+mf+' del '+d+'/'+mes+'/'+y);
        
        try {
            HDI4I_Crono_Email o = new HDI4I_Crono_Email();
            system.schedule(tipo+idE, '0 '+mf+' '+he+' '+d+' '+mes+' ? '+y, o);    
        } catch (Exception e) {
            system.debug('Al crear el Job: ' + e.getMessage());    
        }
        
        
        return '';
    }
    
    public static string idE(String name){
        String r = '';
        
        integer n = integer.valueOf(name.length()-2);
        r = name.right(n);
        return r;
    }

}