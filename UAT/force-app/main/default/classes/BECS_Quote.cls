public without sharing class BECS_Quote extends fflib_SObjectDomain{

    public BECS_Quote(List<Quote> sObjectList) {
		super(sObjectList);
    }

    public override void onAfterUpdate(Map<Id, SObject> sObjectMap) {
        Set<Id> setQuotesToSend = new Set<Id>();
        Map<Id, Quote> oldMap = (Map<Id, Quote>)Trigger.oldMap;
        for (Quote item : (List<Quote>) Records) {
            if (item.hdi4i_ultima_cotizacion_generada__c != oldMap.get(item.id).hdi4i_ultima_cotizacion_generada__c) {
                setQuotesToSend.add(item.id);    
                HDI4I_Crono_Email.crono(item.Id, 'co');
            }
        }

        /* if (!setQuotesToSend.isEmpty()) {
            BECS_EmailService.enviarCorreo('Quote', setQuotesToSend);
        } */
    } 
}