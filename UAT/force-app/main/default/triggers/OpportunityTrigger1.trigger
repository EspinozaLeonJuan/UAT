trigger OpportunityTrigger1 on Opportunity (before insert, before update) {
    
    /* Comentado por Fran Oseguera, INETUM, 23-11-2021, por solicitud del usuario 
    
    if(Trigger.isUpdate && Trigger.isbefore){
        if(HDI4I_ConTest.val){
            if(EnviarCorreo.nuevaPropuesta(Trigger.old, Trigger.new)){
                //EnviarCorreo.Propuestas(Trigger.new);
                for(Opportunity o: Trigger.new){
                    User u = [SELECT MobilePhone, Email, HDIR4I_Firma__c FROM User where id =: o.OwnerId limit 1];
                    o.HDI4I_Firma__c = u.HDIR4I_Firma__c;
                    o.HDI4I_TelEjecutiva__c = u.MobilePhone;
                    o.HDI4I_EmailEjecutiva__c = u.Email;
                    HDI4I_Crono_Email.crono(o.Id, 'pr');
                }
            } 
        }
        
    } */
    
    if(Trigger.isBefore && Trigger.isInsert){
        for(Opportunity o : trigger.new){
            
            if(o.LeadSource == 'VSV2'){
                system.debug('vsv2 trigger 1');
                if(HDI4I_FuncionesAux.existeMarca(o.HDI4I_Id_Marca_vehiculo__c)){
                    
                    o.HDI4I_Marca_objeto__c = HDI4I_FuncionesAux.llamarMarca(o.HDI4I_Id_Marca_vehiculo__c);
                    
                    if(HDI4I_FuncionesAux.existeModelo(o.HDI4I_Id_Modelo_vehiculo__c)){
                        o.HDI4I_Modelo_objeto__c = HDI4I_FuncionesAux.llamarModelo(o.HDI4I_Id_Modelo_vehiculo__c);
                    }else{
                        o.HDI4I_Modelo_objeto__c = HDI4I_FuncionesAux.crearModelo(o.HDI4I_Id_Marca_vehiculo__c, o.HDI4I_Modelo__c, o.HDI4I_Id_Modelo_vehiculo__c);
                    }
                    
                }else{
                    o.HDI4I_Marca_objeto__c = HDI4I_FuncionesAux.crearMarca(o.HDI4I_Marca__c, o.HDI4I_Id_Marca_vehiculo__c);
                    o.HDI4I_Modelo_objeto__c = HDI4I_FuncionesAux.crearModelo(o.HDI4I_Id_Marca_vehiculo__c, o.HDI4I_Modelo__c, o.HDI4I_Id_Modelo_vehiculo__c);
                }
            }
            
            
        }
    }
    
}