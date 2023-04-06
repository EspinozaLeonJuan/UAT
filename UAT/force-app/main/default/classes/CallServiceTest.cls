@isTest
private class CallServiceTest {

    @isTest
    static void updateCallTest() {
      Task tsk = new Task();
      insert tsk;
      
      CallRequest callReq = new CallRequest();
      callReq.id_sf = tsk.Id;
      callReq.fecha = DateTime.now();
      callReq.tiempo_llamado = 125;
      callReq.tiempo_espera = 21;
      callReq.estado_llamado = 'Contestado';
      callReq.id_audio = '1231243324324';

      Test.startTest();
      CallService callServ = new CallService();
      callServ.updateCall(callReq);
      Test.stopTest();

      Task call = [ SELECT Id, Status, CallDurationInSeconds, Llamada_Fecha__c, Llamada_Tiempo_Espera__c, Llamada_Audio_Id__c
                    FROM Task 
                    WHERE Id = :callReq.id_sf LIMIT 1];

      System.assert(callReq.fecha.isSameDay(call.Llamada_Fecha__c), callReq.fecha);
      System.assert(callReq.tiempo_llamado == call.CallDurationInSeconds);
      System.assert(callReq.tiempo_espera == call.Llamada_Tiempo_Espera__c);
      System.assert(callReq.estado_llamado == call.Status);
      System.assert(callReq.id_audio == call.Llamada_Audio_Id__c);
    }
}