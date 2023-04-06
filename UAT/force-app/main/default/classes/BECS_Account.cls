public without sharing class BECS_Account extends fflib_SObjectDomain{
    static Map<String,Schema.RecordTypeInfo> recordtypeMap = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByDeveloperName();
    static id idRecordTypePersonAccount = recordtypeMap.get('PersonAccount').getRecordTypeId();

    public BECS_Account(List<Account> sObjectList) {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new BECS_Account(sObjectList);
        }
    }
    
    public void upsertAccountByRut(List<Account> listAccounts){
        try {
            Schema.SObjectField codigoUnico = Account.Fields.HDI4I_RUT_del_cliente__c;
            Database.upsert(listAccounts, codigoUnico, false);
            System.debug(listAccounts);
        }catch (Exception e) {
            System.debug(LoggingLevel.DEBUG, 'HDI_Contacts: ' + e.getMessage());    
        }
    }

    public static Account fullAccount(String nombreCliente, String apellidoPaterno, String rutCliente, String emailCliente, String telefonoCliente, String digitoVerificadorRutCliente){
        Account newAccount = new Account();
        newAccount.RecordTypeId = idRecordTypePersonAccount;
        newAccount.FirstName = nombreCliente;
        newAccount.LastName = apellidoPaterno;
        newAccount.HDI4I_RUT_del_cliente__c = rutCliente;
        newAccount.HDI4I_Digito_verificador_rut_cliente__c = digitoVerificadorRutCliente;
        newAccount.PersonEmail = BECS_Util.validateEmail(emailCliente);
        newAccount.Phone = telefonoCliente;
        newAccount.PersonMobilePhone = telefonoCliente;

        return newAccount;
    }
}