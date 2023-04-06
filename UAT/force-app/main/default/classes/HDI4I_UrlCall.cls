public with sharing class HDI4I_UrlCall {
    public static HttpCalloutMock mock = null;
    public static HttpResponse makePost(String Json){        
        Url_Oportunidad__mdt direction = [SELECT id,endpoint__c from Url_Oportunidad__mdt Limit 1];
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(direction.endpoint__c);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');          
        system.debug(Json);
        request.setBody(Json);

        if(Test.isRunningTest() && (mock != null)){
            HttpResponse re = mock.respond(request);
            String response = re.getBody();
            HDI4I_UrlController.Url res = (HDI4I_UrlController.Url) System.JSON.deserialize(response, HDI4I_UrlController.Url.class);
            system.debug(res.UrlSimulador);
            HDI4I_UrlController.parse(response);
            return mock.respond(request);
        } else {
            HttpResponse response = http.send(request);
            String responseBody = response.getBody();
            system.debug('Body: '+responseBody);
            return response;
        }
           
    }
}