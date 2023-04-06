public class UrlCall {
    public static HttpCalloutMock mock = null;
    public static HttpResponse makePost(String Json){        
        
        Url_Oportunidad__mdt cotizadorEndpoint = Url_Oportunidad__mdt.getInstance('urlOpp');

        //string h = 'https://www.bufa.es';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        //request.setEndpoint('https://www.hdi.cl/esb-ws/WsCuva/SalesForce.svc/GetUrlCotizador/');
        request.setEndpoint(cotizadorEndpoint.endpoint__c);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');      
        
        system.debug(Json);
        request.setBody(Json);
        if(Test.isRunningTest() && (mock != null)){
            HttpResponse re = mock.respond(request);
            String reBody = re.getBody();
            hdi.Url hola2 = (hdi.Url) System.JSON.deserialize(reBody, hdi.Url.class);
            system.debug(hola2.UrlSimulador);
            hdi.parse(reBody);
            //MockHttpResponseGenerator.respond(re);
            return mock.respond(request);
            
        } else {
            HttpResponse response = http.send(request);
            String responseBody = response.getBody();
            system.debug('Body: '+responseBody);
            
            //hdi.Url hola = (hdi.Url) System.JSON.deserialize(responseBody, hdi.Url.class);
            
            
            return response;
        }
    }
    
    
    
}