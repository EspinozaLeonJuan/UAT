public without sharing class CaseBot_GetSiniestroEstado {

  public class SiniestroOutput {
    @InvocableVariable(required=true)
    public String sOrderStatus;
  }

  public class SiniestroInput {
    @InvocableVariable(required=true)
    public String sOrderNumber;
  }
    
  @InvocableMethod(label='Get Siniestro')
    public static List<SiniestroOutput> getSiniestroStatus(list<SiniestroInput> orderInputs) {
      List<SiniestroOutput> orderOutputs = new List<SiniestroOutput>();   
      SiniestroOutput orderOutput = new SiniestroOutput(); 
        try {
          List<Case> orders = new HDI_CaseSelector().selectByNumSiniestro(orderInputs[0].sOrderNumber);
          
          if (orders.size() > 0) {
              for (Case cas : orders) {
                  orderOutput = new SiniestroOutput();
                  orderOutput.sOrderStatus = 'Tu siniestro número ' + cas.HDI4I_N_Siniestro__c + ' se encuentra en estado "' + cas.Status + '" y tu liquidador ' + cas.HDI4I_Nombre_del_liquidador__c + ' lo está atendiento.';
                  orderOutput.sOrderStatus += ' Si necesita más información, solicite hablar con un agente y su liquidador le responderá lo antes posible';
                  orderOutputs.add(orderOutput);
              }
          }else{
              orderOutput.sOrderStatus = Label.HDI_SiniestroNoEncontrado;
              orderOutputs.add(orderOutput);
          }
        }catch (Exception e) {
          orderOutput.sOrderStatus = Label.HDI_SiniestroNoEncontrado;
          orderOutputs.add(orderOutput);    
        }
        return orderOutputs;    
      }
}