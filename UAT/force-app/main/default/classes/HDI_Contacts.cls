public with sharing class HDI_Contacts extends fflib_SObjectDomain{
    private static final List<Schema.SObjectType> SERVICE_SOBJECTS = new Schema.SObjectType[] { Contact.SObjectType };

    public HDI_Contacts(List<Contact> sObjectList) {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new HDI_Contacts(sObjectList);
        }
    }

    public override void onAfterInsert() {
        HDI_MessagingEndUser messagingEU = new HDI_MessagingEndUser(new List<MessagingEndUser>());
        messagingEU.crearMessagingEndUser(this);
    }

    public override void onAfterUpdate(Map<Id, SObject> sObjectMap) {
        HDI_MessagingEndUser messagingEU = new HDI_MessagingEndUser(new List<MessagingEndUser>());
        //messagingEU.crearMessagingEndUser(this);   
    }


    public List<Contact> crearContact(HDI_Cases cases){
        try {
            List<Contact> listNewContacts = new List<Contact>();
            Id idTRContactIndustriesIndividual = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('IndustriesIndividual').getRecordTypeId();

            for(Case cas : (List<Case>) cases.Records){
                Contact co = new Contact();
                co.RecordTypeId = idTRContactIndustriesIndividual;
                co.LastName = cas.HDI4I_Nombre_del_asegurado__c;
                co.MobilePhone = cas.HDI_CelularAsegurado__c;
                co.Email = cas.SuppliedEmail;
                co.Rut_sin_puntos_y_con_gui_n__c  = cas.HDI4I_Rut_del_asegurado__c;
                listNewContacts.add(co);
            }
            insert listNewContacts;
            return listNewContacts;

        }catch (Exception e) {
            System.debug(LoggingLevel.DEBUG, 'HDI_Contacts: ' + e.getMessage());    
            return null;
        }
    }

}