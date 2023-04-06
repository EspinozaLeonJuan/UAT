public with sharing class HDI_Cases extends fflib_SObjectDomain{
    private static final List<Schema.SObjectType> SERVICE_SOBJECTS = new Schema.SObjectType[] { Case.SObjectType };
    Id idTRCaseSiniestro = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Siniestro').getRecordTypeId();

    public HDI_Cases(List<Case> sObjectList) {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new HDI_Cases(sObjectList);
        }
    }
    
    public override void onBeforeInsert() {
        
        list<Contact> listContactForMessagin = new List<Contact>();

        Set<String> liquidadorIdSet = new Set<String>();
        Set<String> rutSet = new Set<String>();
        Set<String> celularSet = new Set<String>();
        list<Case> listCaseSiniestros = new list<Case>();

        for(Case c : (List<Case>) Records){
            system.debug('Caso a crearse: ' + c + ' creador: ' + c.CreatedById);
            liquidadorIdSet.add(c.HDI4I_ID_del_liquidador__c);
            rutSet.add(c.HDI4I_Rut_del_asegurado__c);    
            celularSet.add(HDI_MessagingEndUser.CONTS_WHATSAPP_CONPUNTOS + c.HDI_CelularAsegurado__c);
            if(c.RecordTypeId == idTRCaseSiniestro){
                //c.EntitlementId = listEntitlement[0].Id;
                listCaseSiniestros.add(c);
            }             
        }         
        
        if(!listCaseSiniestros.isEmpty()){
            //list<Entitlement> listEntitlement = new HDI_EntitlementSelector().selectByDefaultSiniestros();

            //--map<String, User> mapUserLiquidador = getLiquidadores(liquidadorIdSet);
            map<String, SIN_EjecutivoLiquidador__c> mapUserLiquidador = getLiquidadores(liquidadorIdSet);

            map<String, Contact> mapContactRut = new map<String, Contact>();
            for (Contact conta : new HDI_ContactSelector().selectByRut(rutSet)) {
                mapContactRut.put(conta.Rut_sin_puntos_y_con_gui_n__c, conta);
            }

            list<Case> listCaseToCreateContact = new list<Case>();
            for(Case caso : listCaseSiniestros){
                //caso.EntitlementId = listEntitlement[0].Id;
                setCaseOwner(caso, mapUserLiquidador);

                if(mapContactRut.containsKey(caso.HDI4I_Rut_del_asegurado__c)){
                    caso.ContactId = mapContactRut.get(caso.HDI4I_Rut_del_asegurado__c).Id; 
                    listContactForMessagin.add(new Contact(Id = caso.ContactId, LastName = caso.HDI4I_Nombre_del_asegurado__c, MobilePhone = caso.HDI_CelularAsegurado__c)); 
                }else{
                     /*COMENTADO LUCAS NO SE REQUIERE, LINEA DE CODIGO UTILIZADA PARA ENVIAR CORREO */
                    //listCaseToCreateContact.add(caso);    
                }
            }

            if(!listCaseToCreateContact.isEmpty()){
                HDI_Cases casesToCreateCase = new HDI_Cases(listCaseToCreateContact);
                HDI_Contacts createContacts = new HDI_Contacts(new List<Contact>());
                List<Contact> listNewContact = createContacts.crearContact(casesToCreateCase);

                mapContactRut = new map<String, Contact>();
                for (Contact conta: listNewContact) {
                    mapContactRut.put(conta.Rut_sin_puntos_y_con_gui_n__c, conta);
                }

                for(Case caso : (List<Case>) casesToCreateCase.Records){
                    caso.ContactId = mapContactRut.get(caso.HDI4I_Rut_del_asegurado__c).Id;
                }
            }

            /*COMENTADO LUCAS. NO SE REQUIERE ENVIAR CORREO */
            //setMessagingEndUser(rutSet, celularSet, listContactForMessagin); 
        } 
    }

    public override void onBeforeUpdate(Map<Id, SObject> sObjectMap) {
        Set<String> liquidadorIdSet = new Set<String>();
        Map<Id, Case> mapOld = (Map<Id, Case>)Trigger.oldMap;

        for(Case c : (List<Case>) Records){
            if (c.HDI4I_ID_del_liquidador__c != mapOld.get(c.id).HDI4I_ID_del_liquidador__c) {
                liquidadorIdSet.add(c.HDI4I_ID_del_liquidador__c);    
            }
                          
        }     
        if (!liquidadorIdSet.isEmpty()) {
            //--map<String, User> mapUserLiquidador = getLiquidadores(liquidadorIdSet);
            map<String, SIN_EjecutivoLiquidador__c> mapUserLiquidador = getLiquidadores(liquidadorIdSet);

            for(Case caso : (List<Case>) Records){
                setCaseOwner(caso, mapUserLiquidador);
            }    
        }
        
    }

    public override void onAfterUpdate(Map<Id, SObject> sObjectMap) {
        Map<Id, Case> mapOld = (Map<Id, Case>)Trigger.oldMap;
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(SERVICE_SOBJECTS);
        List<Case> listCaseSiniestros = new List<Case>();
        map<Id, Case> mapEndUserMessage = new map<Id, Case>();

        for(Case c : (List<Case>) Records){
            if(c.recordTypeId == idTRCaseSiniestro){
                listCaseSiniestros.add(c);    
                mapEndUserMessage.put(c.Messaging_User__c, c);
            }
        }

        if(!listCaseSiniestros.isEmpty()){
		    //HDI_CaseMilestone.updateCaseMilestone(this, mapOld, uow);
            linkCaseToMessageSession(mapEndUserMessage);
        }
    }

    public void linkCaseToMessageSession(map<Id, Case> mapEndUserMessage){
        List<MessagingSession> listMessageSessionToUpdate = new List<MessagingSession>();

        for(MessagingSession item : new HDI_MessagingSessionSelector().selectByMessageUser(mapEndUserMessage.keySet())){
            System.debug('HDI_Cases: ' + item);
            if(mapEndUserMessage.containsKey(item.MessagingEndUserId)){
                Case caseMessage =  mapEndUserMessage.get(item.MessagingEndUserId);
                System.debug('HDI_Cases: ' + caseMessage.LastModifiedDate);
                if(item.CreatedDate == caseMessage.CreatedDate ||item.CreatedDate == caseMessage.LastModifiedDate ){
                    item.CaseId = caseMessage.id;
                    listMessageSessionToUpdate.add(item);
                }
            }
        }
        try {
            update listMessageSessionToUpdate;    
        } catch (Exception e) {
            System.debug('HDI_Cases: ' + e.getMessage());
        }
    }

    //CAMBIAR POR SIN_EjecutivoLiquidador
    /*
    public map<String, User> getLiquidadores(Set<String> liquidadorIdSet){
        map<String, User> mapUserLiquidador = new map<String, User>();
        for (User usuario : new HDI_UserSelector().selectByLiquidadorId(liquidadorIdSet)) {
            mapUserLiquidador.put(usuario.HDI4I_LiquidadorId__c, usuario);
        }
        System.debug(mapUserLiquidador);
        return mapUserLiquidador;
    }
    */
    
    public map<String, SIN_EjecutivoLiquidador__c> getLiquidadores(Set<String> liquidadorIdSet){
        System.debug(liquidadorIdSet);
        String liq = String.valueOf(liquidadorIdSet).replace('{', '').replace('}', '');
        System.debug(liq);
        List<SIN_EjecutivoLiquidador__c> ej = new HDI_EjecutivoLiquidadorSelector().byLiquidadorId(liq);
        System.debug(ej);
        map<String, SIN_EjecutivoLiquidador__c> mapUserLiquidador = new map<String, SIN_EjecutivoLiquidador__c>();
        for (SIN_EjecutivoLiquidador__c usuario : new HDI_EjecutivoLiquidadorSelector().byLiquidadorId(liq)) {
            System.debug(usuario);
            mapUserLiquidador.put(usuario.Id_Liquidador__c, usuario);
        }
        System.debug(mapUserLiquidador);
        return mapUserLiquidador;
    }
    
//CAMBIAR POR SIN_EjecutivoLiquidador
    /*
    public void setCaseOwner(Case caso, map<String, User> mapUserLiquidador){
        if(mapUserLiquidador.containsKey(caso.HDI4I_ID_del_liquidador__c)){
            caso.OwnerId  = mapUserLiquidador.get(caso.HDI4I_ID_del_liquidador__c).Id;
        } 
    } */
    public void setCaseOwner(Case caso, map<String, SIN_EjecutivoLiquidador__c> mapUserLiquidador){
        if(mapUserLiquidador.containsKey(caso.HDI4I_ID_del_liquidador__c)){
            caso.OwnerId  = mapUserLiquidador.get(caso.HDI4I_ID_del_liquidador__c).Ejecutivo_Siniestro__c;
            caso.SIN_Liquidador__c = mapUserLiquidador.get(caso.HDI4I_ID_del_liquidador__c).Liquidador__c;
            System.debug(caso.OwnerId);
        } 
    }


    public void setMessagingEndUser(Set<String> rutSet, Set<String> celularSet, List<Contact> listContactForMessagin){
        map<String, MessagingEndUser> mapMessaging = new HDI_MessagingEndUserSelector().selectByNumCelular(celularSet);
        if(mapMessaging.isEmpty()){
            HDI_Contacts listContactos = new HDI_Contacts(listContactForMessagin);
            HDI_MessagingEndUser messagingEU = new HDI_MessagingEndUser(new List<MessagingEndUser>());
            messagingEU.crearMessagingEndUser(listContactos);

            mapMessaging = new HDI_MessagingEndUserSelector().selectByNumCelular(celularSet);
        }

        for(Case caso : (List<Case>) Records){
            if(mapMessaging.containsKey(HDI_MessagingEndUser.CONTS_WHATSAPP_CONPUNTOS + caso.HDI_CelularAsegurado__c)){
                caso.Messaging_User__c = mapMessaging.get(HDI_MessagingEndUser.CONTS_WHATSAPP_CONPUNTOS + caso.HDI_CelularAsegurado__c).id;
            }
        }
    }
}