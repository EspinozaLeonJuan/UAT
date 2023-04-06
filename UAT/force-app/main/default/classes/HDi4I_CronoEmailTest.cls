@isTest(SeeAllData=true)
public class HDi4I_CronoEmailTest {
    
    static testMethod void testDoPost3(){
        List<Quote> q = [select id, OpportunityId, Opportunity.HDI4I_Ultima_propuesta_generada__c, hdi4i_ultima_cotizacion_generada__c, Email, name from quote
                     where Email != null and Opportunity.Owner.Email = 'viviana.millan@hdi.cl' 
                     and hdi4i_ultima_cotizacion_generada__c != null limit 1];
        
        ContentVersion contentVersion = new ContentVersion(
        Title =  q[0].hdi4i_ultima_cotizacion_generada__c,
        PathOnClient = 'Updated (4).jpg',
        VersionData = Blob.valueOf('Test Content'),
        IsMajorVersion = true
        );
        insert contentVersion;    
        List<ContentDocument> documents = [
            SELECT Id, Title, LatestPublishedVersionId 
            FROM ContentDocument
        ];
        system.debug(documents);

        //create ContentDocumentLink  record 
        ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = q[0].id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;

        HDI4I_Crono_Email.crono(q[0].id, 'co');

        List<InsurancePolicy> i = [select SourceQuoteId, HDI4I_Ultima_poliza_generada__c, SourceOpportunityId 
                                    from InsurancePolicy where SourceQuoteId != null and SourceOpportunity.Owner.Email = 'viviana.millan@hdi.cl' 
                                    and HDI4I_Ultima_poliza_generada__c != null limit 1];
        
        ContentVersion contentVersion2 = new ContentVersion(
        Title = i[0].HDI4I_Ultima_poliza_generada__c,
        PathOnClient = 'Updated (5).jpg',
        VersionData = Blob.valueOf('Test Content'),
        IsMajorVersion = true
        );
        insert contentVersion2;    

        List<ContentDocument> documents2 = [
            SELECT Id, Title, LatestPublishedVersionId 
            FROM ContentDocument Where Id !=: documents[0].Id
        ];

        //create ContentDocumentLink  record 
        ContentDocumentLink cdl2 = New ContentDocumentLink();
        cdl2.LinkedEntityId = i[0].id;
        cdl2.ContentDocumentId = documents2[0].Id;
        cdl2.shareType = 'V';
        insert cdl2;
        
        HDI4I_Crono_Email.crono(i[0].id, 'po');
        
        //List<Opportunity> op = [Select id, HDI4I_Ultima_propuesta_generada__c, HDI4I_Nombres_contratante__c,HDI4I_Marca__c, HDI4I_Modelo__c, HDI4I_Ano_del_vehiculo__c from Opportunity where id = '0063t000010KT1xAAG'];
        
        //List<Opportunity> op = [Select id, HDI4I_Ultima_propuesta_generada__c, HDI4I_Nombres_contratante__c,HDI4I_Marca__c, HDI4I_Modelo__c, HDI4I_Ano_del_vehiculo__c from Opportunity where owner.email = 'viviana.millan@hdi.cl' limit 1];
        
        HDI4I_Crono_Email.crono(q[0].OpportunityId, 'pr');

    }

}