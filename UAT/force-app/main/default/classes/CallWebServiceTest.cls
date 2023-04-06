@isTest
private class CallWebServiceTest {

	@isTest
	static void updateCallOkTest() {
		setContext();
		RestContext.request.httpMethod = 'POST';

		////mock
		StubCallService stub = StubCallService.newInstance();
		CallService mock = (CallService) Test.createStub(CallService.class, stub);
		////
		CallRequest callReq = new CallRequest();
    callReq.id_sf = '123456';
    callReq.fecha = DateTime.now();
    callReq.tiempo_llamado = 125;
    callReq.tiempo_espera = 21;
    callReq.estado_llamado = 'Contestado';
    callReq.id_audio = '1231243324324';

		RestContext.request.requestBody = Blob.valueOf(JSON.serialize(callReq));

		Test.startTest();
		CallWebService.setService(mock);
		CallWebService.updateCall();
		Test.stopTest();

		System.assertEquals(200, RestContext.response.statusCode);
		System.assertEquals('{"status":"ok"}', RestContext.response.responseBody.toString());
	}

	static void setContext(){
		RestContext.response = new RestResponse();
		RestRequest request = new RestRequest();
		request.requestUri = 'services/apexrest/calls/';
		RestContext.request = request;
	}
}