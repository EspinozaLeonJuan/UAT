@isTest
global class StubCallService implements StubProvider {

	public static StubCallService newInstance() {
		return new StubCallService();
	}

	global Object handleMethodCall(Object stubbedObject, String stubbedMethodName, System.Type returnType,
                                 List<System.Type> listOfParamTypes, List<String> listOfParamNames, List<Object> listOfArgs) {
    if (stubbedMethodName == 'updateCall') {
      return null;
    }
    return null;
  }
}