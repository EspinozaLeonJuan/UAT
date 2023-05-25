public class HDI_TercerosSelector extends fflib_SObjectSelector {
   public List<Schema.SObjectField> getSObjectFieldList() {
      return new List<Schema.SObjectField> {
          HDI4I_Tercero__c.HDI4I_Numero_de_siniestro__c,
          HDI4I_Tercero__c.HDITerceroInvId__c
          //HDI4I_Tercero__c.siniestroNumero__c
      };
  }
  public Schema.SObjectType getSObjectType() {
   return HDI4I_Tercero__c.sObjectType;
}


 
 }