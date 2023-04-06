public with sharing class HDI_MessagingEndUserSelector extends fflib_SObjectSelector{
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            MessagingEndUser.Id,
            MessagingEndUser.MessagingPlatformKey,
            MessagingEndUser.Name,
            MessagingEndUser.ContactId
        };
    }

    public Schema.SObjectType getSObjectType() {
        return MessagingEndUser.sObjectType;
    }
    
    public map<String, MessagingEndUser> selectByNumCelular(Set<String> numCelular) {
        map<String, MessagingEndUser> mapMessaging = new map<String, MessagingEndUser>();
        
        for(MessagingEndUser item : Database.query(newQueryFactory().setCondition('MessagingPlatformKey IN: numCelular').toSOQL())){
            mapMessaging.put(item.MessagingPlatformKey, item);
        }
        return mapMessaging;
    }
}