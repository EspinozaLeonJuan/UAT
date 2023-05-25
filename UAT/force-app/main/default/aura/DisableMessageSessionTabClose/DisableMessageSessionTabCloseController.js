({ 
    // Método que se corre al momento de cargar o modificar el case actual.
    recordUpdate: function(component, event, helper) {       
                                    
        // Tomar el Registro del MessageSession Actual.
        let currentCase = component.get("v.CurrentMessageSession");
        if (currentCase != null) {
            let messageSessionId = currentCase.Id; // Tomar el Id del MessageSession.
            let estado = currentCase.Status; 
            let tipografia = currentCase.Tipografia__c;
            
        	if (estado == "Active" && tipografia == 'CIERRE AUTOMATICO') {
                if (messageSessionId != null ) 
                {                
                	helper.configTab(component, true);  // Deshabilitar Botón Cerrar Tab.               
	            } else {
                    helper.configTab(component, false);  // Habilitar Botón Cerrar Tab.                                 
                }
            } else {
                helper.configTab(component, false); // Habilitar Botón Cerrar Tab. 
            }
        } else {
            helper.configTab(component, false); // Habilitar Botón Cerrar Tab.
        }
    }
})