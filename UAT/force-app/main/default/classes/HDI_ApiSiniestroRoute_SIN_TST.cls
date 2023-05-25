@isTest
public class HDI_ApiSiniestroRoute_SIN_TST {
    @isTest
    static void testHttpGet() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/caso/siniestro'; //Request URL
        req.resourcePath = '/services/apexrest/caso/siniestro';
        req.httpMethod = 'GET';
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        HDI_APISiniestrosRoute_SIN.handleGet();
        Test.stopTest();
    }
    
    @isTest
    static void testHttpPost() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/caso/siniestro'; //Request URL
        req.resourcePath = '/services/apexrest/caso/siniestro';
        req.httpMethod = 'POST';
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        HDI_APISiniestrosRoute_SIN.handlePost();
        Test.stopTest();
    }
    
    @isTest
    static void testHttpPut() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/caso/siniestro'; //Request URL
        req.resourcePath = '/services/apexrest/caso/siniestro';
        req.httpMethod = 'PUT';
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        HDI_APISiniestrosRoute_SIN.handlePut();
        Test.stopTest();
    }
    
    @isTest
    static void testHttpDelete() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/caso/siniestro'; //Request URL
        req.resourcePath = '/services/apexrest/caso/siniestro';
        req.httpMethod = 'DELETE';
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        HDI_APISiniestrosRoute_SIN.handleDelete();
        Test.stopTest();
        
        // Agrega aquí las aserciones necesarias para verificar el comportamiento esperado
    }
}