trigger HDI4I_LeadTrigger on Lead (before insert) {
    
    if(Trigger.isBefore && Trigger.isInsert){
        
        for(Lead l : Trigger.New){           
            
            if(HDI4I_FuncionesAux.existeMarca(l.HDI4I_Id_Marca_vehiculo__c)){
                
                l.HDI4I_Marca_objeto__c = HDI4I_FuncionesAux.llamarMarca(l.HDI4I_Id_Marca_vehiculo__c);
                
                if(HDI4I_FuncionesAux.existeModelo(l.HDI4I_Id_Modelo_vehiculo__c)){
					l.HDI4I_Modelo_objeto__c = HDI4I_FuncionesAux.llamarModelo(l.HDI4I_Id_Modelo_vehiculo__c);
                }else{
                    l.HDI4I_Modelo_objeto__c = HDI4I_FuncionesAux.crearModelo(l.HDI4I_Id_Marca_vehiculo__c, l.HDI4I_Modelo__c, l.HDI4I_Id_Modelo_vehiculo__c);
                }
                
            }else{
                l.HDI4I_Marca_objeto__c = HDI4I_FuncionesAux.crearMarca(l.HDI4I_Marca__c, l.HDI4I_Id_Marca_vehiculo__c);
                l.HDI4I_Modelo_objeto__c = HDI4I_FuncionesAux.crearModelo(l.HDI4I_Id_Marca_vehiculo__c, l.HDI4I_Modelo__c, l.HDI4I_Id_Modelo_vehiculo__c);
            }
        }
    }

}