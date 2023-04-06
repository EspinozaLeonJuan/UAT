public without sharing class CaseBot_GetSiniestroLiquidador {
  
  public class SiniestroOutput {
      @InvocableVariable(required=true)
      public Id sOrderLiquidador;
    }
  
    public class SiniestroInput {
      @InvocableVariable(required=true)
      public String sOrderNumber;
    }
  
    @InvocableMethod(label='Get Liquidador')
    public static List<SiniestroOutput> getSiniestroLiquidador(list<SiniestroInput> orderInputs) {
      List<SiniestroOutput> orderOutputs = new List<SiniestroOutput>();
      SiniestroOutput orderOutput = new SiniestroOutput();

      try {
        
        List<Case> sCaso = new HDI_CaseSelector().selectByNumSiniestro(orderInputs[0].sOrderNumber);

        List<UserServicePresence> verificarConexion = [Select id From UserServicePresence Where IsCurrentState = true and OwnerId =: sCaso[0].OwnerId];

        List<MessagingSession> cantidadActual = [Select id From MessagingSession Where Status = 'Active' AND OwnerId =: sCaso[0].OwnerId];

        System.debug('cantidadActual: ' + cantidadActual.size());
        integer cantidadActualMasNueva = 0;
        cantidadActualMasNueva = cantidadActual.size() + 1;
        System.debug('cantidadActualMasNueva: ' + cantidadActualMasNueva);

        if (!verificarConexion.isEmpty() && cantidadActualMasNueva < 11 ) {
            
            for(GroupMember objMember : [SELECT GroupId FROM GroupMember WHERE UserOrGroupId =: sCaso[0].OwnerId and Group.Developername != 'Ejecutivas_Siniestros']){
                orderOutput = new SiniestroOutput();
                orderOutput.sOrderLiquidador = objMember.GroupId;
                orderOutputs.add(orderOutput);  
            }      
        }

        if(orderOutputs.isEmpty()){
          List<group> defaultQueue = [Select id From group where developername = 'Ejecutivas_Siniestros' limit 1];
          orderOutput.sOrderLiquidador = defaultQueue[0].id;
          orderOutputs.add(orderOutput);  
        }  
      }catch (Exception e) {
        System.debug('CaseBot_GetSiniestroLiquidador: ' + e.getMessage());
      }
      return orderOutputs;    
    }
}