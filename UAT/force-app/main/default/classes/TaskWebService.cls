global class TaskWebService {
   webService static String createTask(String userId, String objId, String objType, String phone){
      Task tsk = new Task();
      tsk.Subject = 'Llamada a ' + phone;
      tsk.Status = 'Not Started';
      tsk.Priority = 'Normal';
      tsk.Type = 'Call';
      //tsk.Phone = phone;
      tsk.OwnerId = userId;

      if( objType == 'Contact' || objType == 'Lead' ) {
        tsk.WhoId = objId;
      } else {
        tsk.WhatId = objId;
      }

      insert(tsk);
      return JSON.serialize(tsk);
   }

   webService static String updateTask(String taskId, String description, String llamadaId, Integer error) {
      Task tsk = [SELECT Id, Description, Llamada_Id__c FROM Task WHERE Id = :taskId LIMIT 1];
      
      if( tsk.Description != null ) {
        tsk.Description = tsk.Description + '\n' + description;
      } else {
        tsk.Description = description;
      }
      tsk.Llamada_Id__c = llamadaId;
     
      if( error > 0) {
        tsk.Description += '\n' + getError(error);
      }
      update tsk;
      return JSON.serialize(tsk);
   }

   static String getError(Integer error) {
      String msg;
      switch on error {
        when 0 {
          msg = 'Llamada correcta';
        }	
        when 1 {
          msg = 'Falta usuario';
        }
        when 2 {
          msg = 'Falta teléfono';
        }
        when 3 {
          msg = 'Agente no existe';
        }
        when 4 {
          msg = 'Agente no se encuentra LOGIN';
        }
        when 5 {
          msg = 'Teléfono no valido';
        }
        when 6 {
          msg = 'Error Discado';
        }
        when else {
          msg = 'Error desconocido';
        }
      }
      return msg;
   }
}