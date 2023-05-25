/**********************************************************************
 Name:  HDI_MessagingEndUser()
 Copyright © 2021  INETUM
 ======================================================
======================================================
Purpose:                                                            
HDI_MessagingEndUser Handle DOMAIN for MessagingEndUser                                                          
======================================================
======================================================
History                                                            
-------                                                            
VERSION  AUTHOR            DATE              DETAIL            Description
   1.0   Fran Oseguera   19/10/2021      INITIAL DEVELOPMENT    CSR: 
***********************************************************************/
public without sharing class HDI_MessagingEndUser extends fflib_SObjectDomain{
	
    public static final String CONTS_WHATSAPP = 'whatsapp';
    public static final String CONTS_WHATSAPP_CONPUNTOS = 'whatsapp:';
    private static final String CONTS_IMPLICITLYOPTEDIN = 'ImplicitlyOptedIn';
    //private static final String CONTS_WHATSAPP_CHANNEL = 'WhatsApp_CL_whatsapp_56958886533'; //SANDBOX
    private static final String CONTS_WHATSAPP_CHANNEL = 'WhatsApp_CL_whatsapp_56971388805'; //PRODUCCION

    public HDI_MessagingEndUser(List<MessagingEndUser> sObjectList)
    {
        super(sObjectList);
    }

    public void crearMessagingEndUser(HDI_Contacts contacts, List<Case> listCases){
        try {

            list<MessagingEndUser> listNewMessagingEndUser = new list<MessagingEndUser>();
            List<MessagingChannel> listMessageChannel = new HDI_MessagingChannelSelector().selectByDeveloperName(CONTS_WHATSAPP_CHANNEL);

            for (Contact cont: (List<Contact>) contacts.Records) {
                MessagingEndUser newMessage = new MessagingEndUser();
                newMessage.MessageType = CONTS_WHATSAPP;
                newMessage.MessagingChannelId = listMessageChannel[0].id;
                newMessage.MessagingPlatformKey = CONTS_WHATSAPP_CONPUNTOS +  cont.MobilePhone;
                newMessage.Name = cont.LastName;
                newMessage.ContactId = cont.id;
                newMessage.MessagingConsentStatus = CONTS_IMPLICITLYOPTEDIN;    
                listNewMessagingEndUser.add(newMessage);
            }
            insert listNewMessagingEndUser;

        } catch (Exception e) {
            System.debug(LoggingLevel.DEBUG, 'HDI_MessagingEndUser: ' + e.getMessage());   
            HDI_Cases.createLog(listCases[0].Id, 'Error al crear messaging user', e.getMessage());    
        }
    }
}