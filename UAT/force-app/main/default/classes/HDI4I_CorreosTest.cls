@isTest(SeeAllData=true)
public class HDI4I_CorreosTest {
    
    static testMethod void testDoPost3(){
        List<Quote> q = [select id, OpportunityId, hdi4i_ultima_cotizacion_generada__c, Email from quote where OpportunityId =: '0063t000010yRAnAAM'];
        q[0].hdi4i_ultima_cotizacion_generada__c = 'Footer_clientes';
        update q;
        
        List<InsurancePolicy> i = [select id, SourceOpportunityId, HDI4I_Ultima_poliza_generada__c, SourceQuoteId from InsurancePolicy where SourceOpportunityId =: '0063t000010KSyAAAW'];
        i[0].HDI4I_Ultima_poliza_generada__c = 'Footer_clientes';
        i[0].SourceQuoteId = q[0].id;
        update i;
        
        
    }
    
    static testMethod void testDoPost4(){
       List<Opportunity> o = [select id, HDI4I_Ultima_propuesta_generada__c from Opportunity where id =: '0063t000010yRD8AAM'];
        o[0].HDI4I_Ultima_propuesta_generada__c = 'Footer_clientes';
        update o; 
    }

}