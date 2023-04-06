@isTest
private class TaskWebServiceTest {

    @isTest
    static void createTaskTest() {
      Contact c = new Contact(Phone = '123456789', LastName = 'El contacto', Rut_sin_puntos_y_con_gui_n__c = '13491543-9');
      insert c;

		  Test.startTest();
      String jsonResult = TaskWebService.createTask(UserInfo.getUserId(), c.Id, 'Contact', '123456789');
		  Test.stopTest();

      System.assert(jsonResult.contains('"Subject":"Llamada a 123456789","Status":"Not Started","Priority":"Normal","Type":"Call"'), jsonResult);
    }

    @isTest
    static void updateTaskTest() {
      Contact c = new Contact(Phone = '123456789', LastName = 'El contacto', Rut_sin_puntos_y_con_gui_n__c = '13491543-9');
      insert c;
      String jsonResult = TaskWebService.createTask(UserInfo.getUserId(), c.Id, 'Contact', '123456789');

      Map<String,Object> m = (Map<String,Object>)JSON.deserializeUntyped(jsonResult);
      Id taskId = (Id)m.get('Id');

		  Test.startTest();
      jsonResult = TaskWebService.updateTask(taskId, 'una descripción', 'llamadaId', 0);
      System.assert(jsonResult.contains('"Description":"una descripción","Llamada_Id__c":"llamadaId"'), jsonResult);

      jsonResult = TaskWebService.updateTask(taskId, 'una descripción', 'llamadaId', 1);
      System.assert(jsonResult.contains('Falta usuario'), jsonResult);

      jsonResult = TaskWebService.updateTask(taskId, 'una descripción', 'llamadaId', 2);
      System.assert(jsonResult.contains('Falta teléfono'), jsonResult);

      jsonResult = TaskWebService.updateTask(taskId, 'una descripción', 'llamadaId', 3);
      System.assert(jsonResult.contains('Agente no existe'), jsonResult);

      jsonResult = TaskWebService.updateTask(taskId, 'una descripción', 'llamadaId', 4);
      System.assert(jsonResult.contains('Agente no se encuentra LOGIN'), jsonResult);

      jsonResult = TaskWebService.updateTask(taskId, 'una descripción', 'llamadaId', 5);
      System.assert(jsonResult.contains('Teléfono no valido'), jsonResult);

      jsonResult = TaskWebService.updateTask(taskId, 'una descripción', 'llamadaId', 6);
      System.assert(jsonResult.contains('Error Discado'), jsonResult);

      jsonResult = TaskWebService.updateTask(taskId, 'una descripción', 'llamadaId', 7);
      System.assert(jsonResult.contains('Error desconocido'), jsonResult);

		  Test.stopTest();
    }
}