public without sharing class HDI_MessagingSessionSelector extends fflib_SObjectSelector{
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            MessagingSession.Id,
            MessagingSession.CreatedDate,
            MessagingSession.MessagingEndUserId
        };
    }

    public Schema.SObjectType getSObjectType() {
        return MessagingSession.sObjectType;
    }
    
    public list<MessagingSession> selectByMessageUser(Set<Id> listMessageUserId) {
        DateTime momentoEjecucion = Datetime.now();
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('MessagingEndUserId IN: listMessageUserId');
        query.setCondition('CreatedDate =:  momentoEjecucion');

        return Database.query( query.toSOQL() );
    }
}