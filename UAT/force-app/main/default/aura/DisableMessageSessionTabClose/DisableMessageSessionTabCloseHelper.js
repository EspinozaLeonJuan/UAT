({
    configTab : function(component, disabled) {
        var workspaceAPI = component.find("workspace");        
        workspaceAPI.getFocusedTabInfo().then(function(response) {
            let parentURL = response.pageReference.state.ws; // Obtener la referencia de la página del Work Space.
            var focusedTabId = response.tabId; // Obtener el Id del tab del caso en pantalla..
            console.log('Focused Tab Id: ' + focusedTabId);
            var parentTabId = response.parentTabId; // Obener el Id del tabl del registro padre del caso. En este caso es la cuenta/account.
            console.log('Parent Tab Id: ' + parentTabId);
            // Verificar que tab es que el debe cerrar.
            let tabToDisabled;            
            /*if (focusedTabId != null) {
                tabToDisabled = focusedTabId;
            } else if(parentTabId != null){
                tabToDisabled = parentTabId;
            }*/
			tabToDisabled = parentTabId;
            // Deshabilitar el tab activo.
            if (tabToDisabled != null) {
                workspaceAPI.disableTabClose
                ({
                    tabId: tabToDisabled,
                    disabled: disabled
                }).then(function(tabInfo) {                    
                    console.log('tabInfo: ' + tabInfo);
                    $A.get('e.force:refreshView').fire();
                }).catch(function(error) {
                    console.log('error: ' + error);
                });
            }
        }).catch(function(error) {
            console.log('error catch ' + error);
        });
    }
})