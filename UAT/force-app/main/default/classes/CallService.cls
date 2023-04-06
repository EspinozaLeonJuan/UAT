public with sharing class CallService {
  public void updateCall(CallRequest call) {
    Task tsk = [ SELECT Id, Status, CallDurationInSeconds, Llamada_Fecha__c, Llamada_Tiempo_Espera__c, Llamada_Audio_Id__c
                 FROM Task 
                 WHERE Id = :call.id_sf LIMIT 1];

    tsk.Status = call.estado_llamado;
    tsk.CallDurationInSeconds = call.tiempo_llamado;
    tsk.Llamada_Fecha__c = call.fecha;
    tsk.Llamada_Tiempo_Espera__c = call.tiempo_espera;
    tsk.Llamada_Audio_Id__c = call.id_audio;
    
    update tsk;
  }
}