public with sharing class CallRequest {
  public String id_sf {set; get;}   //TaskId
  public DateTime fecha {set; get;} //Llamada_Fecha__c
  public Integer tiempo_llamado {set; get;} //CallDurationInSeconds
  public Integer tiempo_espera {set; get;} //Llamada_Tiempo_Espera__c
  public String estado_llamado {set; get;} //Contestado, Abandono, agregar
  public String id_audio {set; get;} //Llamada_Audio_Id__c
}