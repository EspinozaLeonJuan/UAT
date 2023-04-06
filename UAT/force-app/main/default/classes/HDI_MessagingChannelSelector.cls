/**********************************************************************
 Name:  HDI_MessagingChannelSelector()
 Copyright © 2021  INETUM
 ======================================================
======================================================
Purpose:                                                            
MessagingChannel Selector Selector Handle SOQL for MessagingChannel                                                          
======================================================
======================================================
History                                                            
-------                                                            
VERSION  AUTHOR            DATE              DETAIL            Description
   1.0   Fran Oseguera   19/10/2021      INITIAL DEVELOPMENT    CSR: 
***********************************************************************/
public with sharing class HDI_MessagingChannelSelector extends fflib_SObjectSelector{

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            MessagingChannel.Id,
            MessagingChannel.developerName,
            MessagingChannel.isActive,
            MessagingChannel.masterLabel,
            MessagingChannel.messageType,
            MessagingChannel.messagingPlatformKey
        };
    }

    public Schema.SObjectType getSObjectType() {
        return MessagingChannel.sObjectType;
    }
    
    public List<MessagingChannel> selectByDeveloperName(String developerName) {
        return (List<MessagingChannel>) Database.query(
            newQueryFactory().
            setCondition('developerName =: developerName AND isActive = True').
            toSOQL()
        );
    }
    
}