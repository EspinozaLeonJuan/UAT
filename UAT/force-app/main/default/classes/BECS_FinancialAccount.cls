public without sharing class BECS_FinancialAccount extends fflib_SObjectDomain{

    static Map<String,Schema.RecordTypeInfo> recordtypeMap = Schema.getGlobalDescribe().get('FinServ__FinancialAccount__c').getDescribe().getRecordTypeInfosByDeveloperName();
    static id idDatosBancarios = recordtypeMap.get('BECS_DatosBancarios').getRecordTypeId();

    public BECS_FinancialAccount(List<FinServ__FinancialAccount__c> sObjectList) {
        super(sObjectList);
    }

    public void upsertFinancialAccount(List<FinServ__FinancialAccount__c> listFinancialAccounts){
        try {
            Schema.SObjectField codigoUnico = FinServ__FinancialAccount__c.Fields.BECS_Numerodetarjeta__c;
            Database.upsert(listFinancialAccounts, codigoUnico, false);

        }catch (Exception e) {
            System.debug(LoggingLevel.DEBUG, 'BECS_FinancialAccount: ' + e.getMessage());    
        }
    }

    public static FinServ__FinancialAccount__c fullFinancialAccount(String cuentaRUT, String banco, String numeroTarjeta, 
                                                                    String sucursal, String tipoRegistroDeveloperName){

        FinServ__FinancialAccount__c newAccount = new FinServ__FinancialAccount__c();
        newAccount.RecordTypeId = recordtypeMap.get(tipoRegistroDeveloperName).getRecordTypeId();
        newAccount.Name = cuentaRUT + ' ' + numeroTarjeta;
        newAccount.FinServ__PrimaryOwner__r = new Account(HDI4I_RUT_del_cliente__c = cuentaRUT);

        if (tipoRegistroDeveloperName == 'BECS_DatosBancarios') {
            newAccount.BECS_Banco__c = banco;
            newAccount.BECS_Numerodetarjeta__c = numeroTarjeta;
            newAccount.BECS_Sucursal__c = sucursal;    
            //newAccount.BECS_TipodeTarjeta__c 
        }
        return newAccount;
    }

    public override void onAfterUpdate(Map<Id, SObject> sObjectMap) {
        Set<Id> setPolicyToSend = new Set<Id>();
        Map<Id, FinServ__FinancialAccount__c> oldMap = (Map<Id, FinServ__FinancialAccount__c>)Trigger.oldMap;
        for (FinServ__FinancialAccount__c item : (List<FinServ__FinancialAccount__c>) Records) {
            if (item.BECS_UltimaPolizaGenerada__c != oldMap.get(item.id).BECS_UltimaPolizaGenerada__c) {
                setPolicyToSend.add(item.id);    
                HDI4I_Crono_Email.crono(item.Id, 'po');
            }
        }

        /* if (!setPolicyToSend.isEmpty()) {
            BECS_EmailService.enviarCorreo('FinServ__FinancialAccount__c', setPolicyToSend);
        } */
    }
}