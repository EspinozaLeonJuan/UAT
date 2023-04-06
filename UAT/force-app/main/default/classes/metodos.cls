global class metodos {
    
    global static boolean cambio(List<User> antiguo, List<User> nuevo){
        
        boolean check = false;
        
        for(User a : antiguo){
            for(User n : nuevo){
                if(a.HDI4I_on_off__c != n.HDI4I_on_off__c){
                    check = true;
                }else{
                    check = false;
                }
            }
        }
        return check;
    }
    
    global static void correo(List<User> usuario){
        
        integer h = integer.valueof(string.valueOf(system.now().hour()));
        integer m = integer.valueof(string.valueOf(system.now().minute()));
        integer s = integer.valueof(string.valueOf(system.now().second()));
        string y = string.valueOf(system.now().year());
        string d = string.valueOf(system.now().day());
        string mes = string.valueOf(system.now().month());
        string mensaje = '';
        String fecha = ' a las: '+h+':'+m+' del '+d+'/'+mes+'/'+y;
        
        for(User u: usuario){
            
            if(u.HDI4I_on_off__c == true){
                mensaje = 'Conexión';
            }else{
                mensaje = 'Desconexión';
            }
            system.debug(u.name+' '+u.Username);
            String emailAddress = 'pruebaerroreshdi2@gmail.com';
            string body = string.valueOf('<b>'+u.Username+'</b><br/><br/>'+mensaje+fecha);
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new String[] { emailAddress });
            List<OrgWideEmailAddress> addresses1 = [SELECT Id FROM OrgWideEmailAddress WHERE Address = 'ccortes@cuatroi.com'];
            email.setOrgWideEmailAddressId(addresses1[0].id);
            email.setSubject(mensaje+' '+u.Username);
            email.setHtmlBody(body);
            try {
                Messaging.SendEmailResult[] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
                system.debug(r);
            } catch (Exception e) {
                throw e;
            }
        }                    
    }
}