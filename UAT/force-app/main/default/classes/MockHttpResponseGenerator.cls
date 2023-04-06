@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        System.assertEquals('https://www.hdi.cl/esb-ws/WsCuva/SalesForce.svc/GetUrlCotizador/', req.getEndpoint());
        System.assertEquals('POST', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{'+
    '"UrlSimulador": "http://hdimigdesweb.hdi.cl/amsa/cotizador-web/login.aspx?prodId=AmiK5HriFxc%3d&patente=AobDe0srUQw%3d&rutCon=b5IkFI%2biuNcc1hAX%2bCdS6Q%3d%3d&dvCon=Dbc2Yhs88Sg%3d&tvId=HPAmgXSyqYg%3d&marId=Mk%2fscrIKnAw%3d&modId=kCdGVG3s9XY%3d&annio=d3WqtM%2bfTRw%3d&nuevo=V%2fajvn%2bYNZw%3d&usuId=M8OYNUmHFnqSMb2ld2cScQ%3d%3d&venId=UGUk0J6q7Ic%3d&tuId=HPAmgXSyqYg%3d&vig=pXolH7S87wo%3d&ded=Ec%2fXvtsHj3Y%3d&camId=HPAmgXSyqYg%3d&rutcorr=%2bO0sojCHRVUPAeT07B%2bsyA%3d%3d",'+
    '"transaccion": {'+
        '"estadoTrx": 0,'+
        '"codigoError": 0,'+
        '"glosaError": ""'+
    '}'+
'}');
        res.setStatusCode(200);
        return res;
    }
}