@RestResource(urlMapping='/calls/*')
global with sharing class CallWebService {

	private static CallService callService;

	/**
	 * Para injectar mock
	 */
	public static void setService(CallService service) {
		callService = service;
	}

	public static CallService getService() {
		if (callService == null) {
			callService = new CallService();
		}
		return callService;
	}

	@HttpPost
	global static void updateCall() {
		RestRequest request = RestContext.request;
		CallRequest callReq = (CallRequest) JSON.deserialize(request.requestbody.tostring(), CallRequest.class);
      
    getService().updateCall(callReq);
	  RestContext.response.statusCode = 200; 
		RestContext.response.responseBody = Blob.valueOf('{"status":"ok"}');
	}
}