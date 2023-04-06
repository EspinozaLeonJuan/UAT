public without sharing class HDI_Tasks extends  fflib_SObjectDomain{
    
    public HDI_Tasks(List<Task> sObjectList) {
        super(sObjectList);
    }
    
    public override void onBeforeInsert() {
        Set<String> listOpportunityId = new Set<String>();

        for(Task item : (List<Task>) Records){
            if(item.BECS_Oportunidad__c != null){
                listOpportunityId.add(item.BECS_Oportunidad__c);
                item.BECS_UltimaLlamada__c = True;
            }
        }

         if(!listOpportunityId.isEmpty()) {
            list<Task> listTareasExistentes = new HDI_TaskSelector().selectByOpportunity(listOpportunityId);
            
            if(!listTareasExistentes.isEmpty()){
                for (Task item : listTareasExistentes) {
                    item.BECS_UltimaLlamada__c = False;    
                }
                update listTareasExistentes;
            }
        }
    }

}