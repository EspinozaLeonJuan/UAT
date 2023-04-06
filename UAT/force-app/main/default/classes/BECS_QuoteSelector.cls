public without sharing class BECS_QuoteSelector extends fflib_SObjectSelector{

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Quote.Id,
            Quote.hdi4i_ultima_cotizacion_generada__c, 
            Quote.Email, 
            Quote.OpportunityId, 
            Quote.name, 
            Quote.ownerid,
            Quote.ContactId,
            Quote.hdi4i_ultima_cotizacion_generada__c 
        };
    }
    
    public Schema.SObjectType getSObjectType() {
        return Quote.sObjectType;
    }
    
    public List<Quote> selectById(Set<Id> setQuoteId) {
        fflib_QueryFactory queryFactory = newQueryFactory();
        queryFactory.selectField('Opportunity.HDI4I_Campana_cotizador_web__c');
        queryFactory.selectField('Opportunity.BECS_BancoEstado__c');
        queryFactory.selectField('Opportunity.Owner.Email');
        queryFactory.selectField('Account.PersonContactId');
        queryFactory.setCondition('id IN: setQuoteId');
        return Database.query( queryFactory.toSOQL() );
    }

    public List<Quote> selectByOpportunityId(List<Id> listOpportunityId) {
        fflib_QueryFactory queryFactory = newQueryFactory();
        queryFactory.setCondition('OpportunityId IN: listOpportunityId');
        return Database.query( queryFactory.toSOQL() );
    }
}