global class HDI4I_RoundRobin_Crono implements Schedulable{
    
    global void execute(SchedulableContext ctx){
        
        try {
            
            String idCtx = ctx.getTriggerId();
            System.abortJob(idCtx);
            buildDataAsignacion(True);

        } catch (Exception e) {
            system.debug('Error en el Round Robin: ' + e.getMessage());        
        }
        crono();
    }

    public static void buildDataAsignacion(boolean isByRoundRobin){
        User IntegradorInstallCall = [Select userName From User Where IntegradorInstantCall__c = True Limit 1];
            
        // Agregado por Fran INETUM, para asignar ejecutivas por campañas
        list<Opportunity> listOppEcomerce = new list<Opportunity>();
        list<Opportunity> listOppBancoEstado = new list<Opportunity>();

        for(Opportunity op : [Select id, owner.name, CreatedDate, StageName, HDI4I_Id_Oportunidad_web__c, BECS_BancoEstado__c, HDI4I_Campana_cotizador_web__c 
                                from opportunity 
                                Where OwnerId =: IntegradorInstallCall.Id and stagename = 'Nuevo' and 
                                HDI4I_Id_Oportunidad_web__c != null  and
                                CreatedDate > 2021-07-01T17:49:16.000+0000  order by CreatedDate desc limit 100]){

            if(op.BECS_BancoEstado__c || op.HDI4I_Campana_cotizador_web__c == 'Campaña VSV Banco Estado' || op.HDI4I_Campana_cotizador_web__c == 'Campaña Ejecutivo Banco Estado' ){
                listOppBancoEstado.add(op);
            }else{
                listOppEcomerce.add(op);    
            }
        }
        
        list<HDI4I_Estado_ejecutivas_call_center__c> listEjecutivoEcomerce = new list<HDI4I_Estado_ejecutivas_call_center__c>();
        list<HDI4I_Estado_ejecutivas_call_center__c> listEjecutivoBancoEstado = new list<HDI4I_Estado_ejecutivas_call_center__c>();

        for (HDI4I_Estado_ejecutivas_call_center__c ejecutivo : asig()) {
            if(ejecutivo.HDI_Campana__c == 'Banco Estado'){
                listEjecutivoBancoEstado.add(ejecutivo);
            }else {
                listEjecutivoEcomerce.add(ejecutivo);
            }    
        }

        system.debug('Oportunidades Banco Estado: ' + listOppBancoEstado.size());
        system.debug('Ejecutivas Banco Estado: ' + listEjecutivoBancoEstado.size());
        system.debug('Oportunidades Ecommerce: ' + listOppEcomerce.size());
        system.debug('Ejecutivas Ecommerce: ' + listEjecutivoEcomerce.size());

        if (isByRoundRobin) {
            if(!listOppBancoEstado.isEmpty() && !listEjecutivoBancoEstado.isEmpty()){
                executeRoundRobin(listOppBancoEstado, listEjecutivoBancoEstado);
            }
    
            if(!listOppEcomerce.isEmpty() && !listEjecutivoEcomerce.isEmpty()){
                executeRoundRobin(listOppEcomerce, listEjecutivoEcomerce);
            }    
        }else{

            if(!listOppBancoEstado.isEmpty() && !listEjecutivoBancoEstado.isEmpty()){
                executePull(listOppBancoEstado, listEjecutivoBancoEstado);
            }
    
            if(!listOppEcomerce.isEmpty() && !listEjecutivoEcomerce.isEmpty()){
                executePull(listOppEcomerce, listEjecutivoEcomerce);
            } 
        }
        
    }

    public static void executeRoundRobin(List<Opportunity> op, List<HDI4I_Estado_ejecutivas_call_center__c> a ){
        
        Integer i = 0;
        Integer actual = 0;
        Integer proximo = 0;
        Boolean ultimo = false;
        integer cantidadOp = 0;
        integer computo = 0;
        integer puesto = 0;
        
        cantidadOp = op.size();
        
        for(Opportunity v:op){
            
            system.debug('Cantidad de ej: '+a.size());
            for(HDI4I_Estado_ejecutivas_call_center__c e : a){
                //CIRCUITO #1
                //ESTABLECER VARIABLES
                //actual  (ESTABLECE EL EJECUTIVO ACTUAL; SI actual == 0 LA COLA NO TIENE ASIGNADOS AÚN)
                //proximo (ESTABLECE EL EJECUTIVO QUE SERÁ ASGINADO; SI actual == 0 -> proximo = 1)
                //ultimo  (DETERMINA SI EL ÚLTIMO EJECUTIVO ES EL ACTUAL ASIGNADO)
                i++;
                System.debug('DEBUG i: '+i+' -- ESTADO DE VARIABLES actual = '+actual+', proximo = '+proximo+', ultimo = '+ultimo);
                if(e.HDI4I_Asignacion__c){
                    //Hemos encontrado al ejecutivo actualmente asignado
                    //Asignamos el próximo como el siguiente de la lista
                    actual = i;
                    proximo = actual + 1;
                    System.debug('DEBUG: encontramos al asignado: '+e.HDI4I_Nombre_completo_ejecutiva__c);
                    System.debug('DEBUG i: '+i+' -- ESTADO DE VARIABLES actual = '+actual+', proximo = '+proximo+', ultimo = '+ultimo); 
                }
                if(i == a.size() && e.HDI4I_Asignacion__c){
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
            for(HDI4I_Estado_ejecutivas_call_center__c e : a){
                //CIRCUITO #2
                //DEFINIR EL EJECUTIVO ASIGNADO
                //El ejecutivo asignado es 'proximo'
                i++;
                if(e.HDI4I_Asignacion__c) {
                    
                    //Asignar
                    system.debug('Asigno '+v.HDI4I_Id_Oportunidad_web__c+' '+v.id+' a '+e.HDI4I_Nombre_completo_ejecutiva__c);
                    e.HDI4I_Cantidad__c = e.HDI4I_Cantidad__c + 1;
                    v.OwnerId = e.HDI4I_Ejecutiva__c;
                    v.BECS_FechadeAsignacion__c = system.now();
                }
            }
            i = 0;
            for(HDI4I_Estado_ejecutivas_call_center__c e : a){
                //CIRCUITO #3
                //CAMBIAR EL ASIGNADO ACTUAL (YA ASIGNADO)
                i++;
                if(i == actual) {
                    e.HDI4I_Asignacion__c = false;                    
                    System.debug('DEBUG: asignado actual ('+e.HDI4I_Nombre_completo_ejecutiva__c+') es removido');
                    //update e;
                }
                if(i == proximo) {
                    e.HDI4I_Asignacion__c = true;
                    System.debug('DEBUG: asignado actual ('+e.HDI4I_Nombre_completo_ejecutiva__c+') es asignado');
                    //update e;
                }
            }
            i = 0;
        }

        try{
            update op;            
            update a;
        }catch(DmlException x){
            system.debug('ERROR: '+x.getMessage());
        }     
    }

    public static void executePull(List<Opportunity> op, List<HDI4I_Estado_ejecutivas_call_center__c> a ){
        Integer i = 0;
        Integer actual = 0;
        Integer proximo = 0;
        Boolean ultimo = false;
        integer cantidadOp = 0;
        integer computo = 0;
        integer puesto = 0;
        
        cantidadOp = op.size();
        computo = cantidadOp;
        system.debug('Cantidad de eje: '+a.size());
        system.debug('Cantidad de oportunidades: '+cantidadOp);
        
        for(HDI4I_Estado_ejecutivas_call_center__c e : a){
            double h = cantidadOp*(e.HDI4I_Porcentaje_asignacion__c/100);
            long l = h.round();
            system.debug(e.HDI4I_Porcentaje_asignacion__c+'%'+' Le corresponden '+l+' oportunidades a '+e.HDI4I_Nombre_completo_ejecutiva__c);
            if(computo != 0){
                if(l > computo){
                    l = computo;
                    system.debug('nuevo número: '+l);
                }
                
                for(integer z=0; z<l; z++){
                    e.HDI4I_Cantidad__c = e.HDI4I_Cantidad__c + 1;

                    system.debug(op[puesto].CreatedDate + ' valor z:'+z+' Puesto de lista: '+puesto);
                    op[puesto].OwnerId = e.HDI4I_Ejecutiva__c;
                    op[puesto].HDI4I_Asignado_Pull__c = True;
                    op[puesto].BECS_FechadeAsignacion__c = system.now();
                    try{
                        System.debug('Oportunidad '+op[puesto].HDI4I_Id_Oportunidad_web__c+' Asignada a '+e.HDI4I_Nombre_completo_ejecutiva__c);
                        computo = computo - 1;
                        puesto = puesto + 1;
                    }catch(DmlException x){
                        system.debug('ERROR: '+x.getMessage());
                    }                            
                    system.debug('computo: '+op.size()+ ' otro computo: '+computo+' Puesto lista: '+puesto);
                }                                              
            }                       
        }
                              
        try{
            update op;            
            update a;
        }catch(DmlException x){
            system.debug('ERROR: '+x.getMessage());
        }           
    }

    public static List<HDI4I_Estado_ejecutivas_call_center__c> asig(){
        String ejecutivasquery = 'SELECT Id, HDI4I_Nombre_completo_ejecutiva__c, HDI4I_Asignacion__c, HDI4I_Ejecutiva__c, HDI4I_Cantidad__c , HDI4I_Porcentaje_asignacion__c, HDI_Campana__c ';
        ejecutivasquery += ' FROM HDI4I_Estado_ejecutivas_call_center__c ';
        ejecutivasquery += ' Where HDI4I_On_Off__c = true ';
        ejecutivasquery += ' Order by HDI4I_Porcentaje_asignacion__c desc';

        return Database.query(ejecutivasquery);
    }
        
    public static string crono(){
        integer tiempo = 10;

        DateTime myDateTime = system.now();
        DateTime newDateTime = myDateTime.addMinutes(tiempo);
        if (newDateTime.hour() >= 22) {
            newDateTime = newDateTime.addHours(integer.valueOf(Label.HoraRounRobinOpportunidades));    
            Date fechaInicio = date.newInstance(0001, 1, 1);

            Integer esFinDeSemana = Math.mod(fechaInicio.daysBetween(date.valueOf(newDateTime)) , 7);
            if(esFinDeSemana == 0 || esFinDeSemana == 1){
                newDateTime = newDateTime.addDays(2);   
            }
        }

        integer h = integer.valueof(string.valueOf(newDateTime.hour()));
        integer m = integer.valueof(string.valueOf(newDateTime.minute()));
        integer s = integer.valueof(string.valueOf(newDateTime.second()));
        string y = string.valueOf(newDateTime.year());
        string d = string.valueOf(newDateTime.day());
        string mes = string.valueOf(newDateTime.month());
        integer me = m; // + tiempo; No necesario, INETUM
        integer he = 0;
        integer mf = 0;
        integer r = 0;
        string hes = '';
        string mfs = '';
        string ss = '';
        Integer randomNumber = Integer.valueof((Math.random() * 1000000));
        string rn = string.valueOf(randomNumber);

        he = h;
        mf = me;
        
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
        
        HDI4I_RoundRobin_Crono o = new HDI4I_RoundRobin_Crono();
        system.schedule('Asig-'+rn, '0 '+mf+' '+he+' '+d+' '+mes+' ? '+y, o);        
        
        return '';
    }
    
}