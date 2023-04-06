@isTest(SeeAllData=true)
public class ControllerOpportunityTest {
    
    static testMethod void testDoPost2(){
        UrlCall.mock = new MockHttpResponseGenerator();
        List<Opportunity> opo = [Select id, HDI4I_Id_Oportunidad_web__c, owner.name, CreatedDate, OwnerId, stagename, HDI4I_Fecha_de_asignacion__c 
                                 from opportunity where OwnerId =: '0053t000007QVfhAAG' and stagename = 'Nuevo' and HDI4I_Id_Oportunidad_web__c != null order by CreatedDate limit 1];
        
        PageReference myVfPage = page.UrlOpportunity;
        Test.setCurrentPage(myVfPage);
        ApexPages.currentPage().getParameters().put('id',opo[0].id);
        ControllerUrlOpportunity con = new ControllerUrlOpportunity();
        con.getId = opo[0].id;
    }

}