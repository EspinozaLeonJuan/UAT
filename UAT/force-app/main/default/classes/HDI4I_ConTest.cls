public with sharing class HDI4I_ConTest {
    
    static string perfilUsuarioEstandar = 'Usuario estándar HDI Seguros';

    public List<User> usu = new List<User>();
    public List<Opportunity> op2 = new List<Opportunity>();
    public List<Opportunity> st = new List<Opportunity>();
    public List<Opportunity> oportunidad {get; set;}
    public String pOld {get;set;}
    public String pNew {get;set;}
    public String ss {get;set;}
    public String rut {get;set;}
    public Integer cant {get;set;}
    public List<String> ii {get;set;}
    public static boolean val = true;
    
    public HDI4I_ConTest(){
        oportunidad = [SELECT Id, Name, OwnerId, Owner.Name, stagename, HDI4I_Asignado_Pull__c, HDI4I_Asignacion_VF__c, CreatedDate 
                    FROM Opportunity where owner.profile.Name =: perfilUsuarioEstandar order by CreatedDate desc limit 30];
        this.cant = oportunidad.size();
    }
    
    public List<SelectOption> usuarios{
        get{
            List<String> listEjecutivas = new List<String>();
            for (HDI4I_Estado_ejecutivas_call_center__c item : [Select HDI4I_Ejecutiva__c From HDI4I_Estado_ejecutivas_call_center__c]) {
                listEjecutivas.add(item.HDI4I_Ejecutiva__c);    
            }

            //usu = [Select id, name from User where profileid =: '00e3t000001CqT9AAK' order by name ];
            usu = [Select id, name from User where Id In: listEjecutivas order by name ];
            
            usuarios = new List<SelectOption>();
            usuarios.add(new SelectOption('Todos', '--Ninguno--'));
            for(User u : usu){
                usuarios.add(new SelectOption(u.id, u.name));
            }
            //usuarios.add(new SelectOption('0053t000007QVfhAAG', 'Consultor'));
            usuarios.add(new SelectOption('Todos', 'Todos'));
            return usuarios;
        }
        set;
    }
    
    public List<SelectOption> stage{
        get{
            //AggregateResult[] g = [select stagename j from opportunity group by stagename];
            stage = new List<SelectOption>();
            stage.add(new SelectOption('Todos', '--Ninguno--'));
            stage.add(new SelectOption('Nuevo', 'Nuevo'));
            stage.add(new SelectOption('Cotizando', 'Cotizando'));
            stage.add(new SelectOption('Envío Cotización', 'Envío Cotización'));
            stage.add(new SelectOption('Esperando Respuesta', 'Esperando Respuesta'));
            stage.add(new SelectOption('Contratando', 'Contratando'));
            stage.add(new SelectOption('Inspección', 'Inspección'));
            stage.add(new SelectOption('Ganada', 'Ganada'));
            stage.add(new SelectOption('Perdida', 'Perdida'));
            /*for(AggregateResult a : g){
                string s = string.valueOf(a.get('j'));
                stage.add(new SelectOption(s, s));
            }*/
            stage.add(new SelectOption('Todos', 'Todo'));
            return stage;
        }
        set;
    }
    
    public PageReference buscar(){
        
        if(pOld != 'Todos'){
            if(ss != 'Todos'){
                this.oportunidad = [SELECT Id, Name, OwnerId, Owner.Name, stagename, HDI4I_Asignado_Pull__c, HDI4I_Asignacion_VF__c, CreatedDate from Opportunity where stagename =: ss and ownerId =: pOld order by CreatedDate desc limit 1000];
                this.cant = oportunidad.size();
            } else {
                this.oportunidad = [SELECT Id, Name, OwnerId, Owner.Name, stagename, HDI4I_Asignado_Pull__c, HDI4I_Asignacion_VF__c, CreatedDate from Opportunity where ownerId =: pOld order by CreatedDate desc limit 1000];
                this.cant = oportunidad.size();
            }
        }else{
            if(ss != 'Todos'){
                //this.oportunidad = [SELECT Id, Name, OwnerId, Owner.Name, stagename, HDI4I_Asignado_Pull__c, HDI4I_Asignacion_VF__c, CreatedDate from Opportunity where owner.profileid =: '00e3t000001CqT9AAK' and stagename =: ss order by CreatedDate desc limit 1000];
                this.oportunidad = [SELECT Id, Name, OwnerId, Owner.Name, stagename, HDI4I_Asignado_Pull__c, HDI4I_Asignacion_VF__c, CreatedDate from Opportunity where owner.profile.Name =: perfilUsuarioEstandar and stagename =: ss order by CreatedDate desc limit 1000];
                this.cant = oportunidad.size();
            } else {
                //this.oportunidad = [SELECT Id, Name, OwnerId, Owner.Name, stagename, HDI4I_Asignado_Pull__c, HDI4I_Asignacion_VF__c, CreatedDate from Opportunity where owner.profileid =: '00e3t000001CqT9AAK' order by CreatedDate desc limit 1000];
                this.oportunidad = [SELECT Id, Name, OwnerId, Owner.Name, stagename, HDI4I_Asignado_Pull__c, HDI4I_Asignacion_VF__c, CreatedDate from Opportunity where owner.profile.Name =: perfilUsuarioEstandar order by CreatedDate desc limit 1000];
                this.cant = oportunidad.size();
            }
        }
        
        
        return null;
    }
    public PageReference asignar(){
        
        if(pNew != 'Todos'){
            for (Opportunity o : oportunidad){
                system.debug(o.name+' '+o.Owner.name);
                o.OwnerId = pNew;
                o.HDI4I_Asignado_Pull__c = false;
                
            }
            update oportunidad;
        }
        return null;
    }

    public PageReference todas(){
        
        //this.oportunidad = [SELECT Id, Name, OwnerId, Owner.Name, stagename, HDI4I_Asignado_Pull__c, HDI4I_Asignacion_VF__c, CreatedDate FROM Opportunity where owner.profileid =: '00e3t000001CqT9AAK' order by CreatedDate limit 500];
        this.oportunidad = [SELECT Id, Name, OwnerId, Owner.Name, stagename, HDI4I_Asignado_Pull__c, HDI4I_Asignacion_VF__c, CreatedDate FROM Opportunity where owner.profile.Name =: perfilUsuarioEstandar order by CreatedDate limit 500];
        this.cant = oportunidad.size();
        return null;
    }

    public PageReference buscarRut(){
        
        string r = rut;
        
        if(r.length()>=8){
            integer l = r.length()-1;
            r = r.left(l); 
            this.oportunidad = [SELECT Id, Name, OwnerId, Owner.Name, stagename, HDI4I_Asignado_Pull__c, HDI4I_Asignacion_VF__c, CreatedDate FROM Opportunity where HDI4I_RUT_del_cliente__c =: r order by CreatedDate desc];
            this.cant = oportunidad.size();
        }
        
        return null;
    }

    public PageReference sinAsignar(){
        /* this.oportunidad = [SELECT Id, Name, OwnerId, Owner.Name, stagename, HDI4I_Asignado_Pull__c, HDI4I_Asignacion_VF__c, CreatedDate 
                            FROM Opportunity where ownerId =: '0053t000007QVfhAAG' and stagename =: 'Nuevo'  and CreatedDate >2021-06-27T17:49:16.000+0000 order by CreatedDate desc limit 1000];
              */        
        this.oportunidad = [SELECT Id, Name, OwnerId, Owner.Name, stagename, HDI4I_Asignado_Pull__c, HDI4I_Asignacion_VF__c, CreatedDate 
        FROM Opportunity where owner.IntegradorInstantCall__c = True and stagename =: 'Nuevo'  and CreatedDate >2021-06-27T17:49:16.000+0000 order by CreatedDate desc limit 1000];             
        this.cant = oportunidad.size();
        return null;
    }

    public PageReference todasEj(){
        //this.oportunidad = [SELECT Id, Name, OwnerId, Owner.Name, stagename, HDI4I_Asignado_Pull__c, HDI4I_Asignacion_VF__c, CreatedDate FROM Opportunity where owner.profileid =: '00e3t000001CqT9AAK' and stagename =: 'Nuevo'];
        this.oportunidad = [SELECT Id, Name, OwnerId, Owner.Name, stagename, HDI4I_Asignado_Pull__c, HDI4I_Asignacion_VF__c, CreatedDate FROM Opportunity where owner.profile.Name =: perfilUsuarioEstandar and stagename =: 'Nuevo'];
        this.cant = oportunidad.size();
        return null;
    }

    public PageReference asignar2(){
        List<Opportunity> lista = new List<Opportunity>();
        for (Opportunity o : oportunidad){
            if(o.HDI4I_Asignacion_VF__c){
                lista.add(o);
                //system.debug(o.name+' '+o.Owner.name);
                //o.OwnerId = pNew;
                //o.HDI4I_Asignado_Pull__c = false;
                //o.HDI4I_Asignacion_VF__c = false;
                //update o;
            }
        }
        for(Opportunity o : lista){
            system.debug(o.name);
            o.OwnerId = pNew;
            o.HDI4I_Asignado_Pull__c = false;
            o.HDI4I_Asignacion_VF__c = false;
            //val = false;
        }
        update lista;
        //buscar();
        
        return null;
    }
}