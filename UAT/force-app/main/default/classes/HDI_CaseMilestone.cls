public without sharing class HDI_CaseMilestone extends fflib_SObjectDomain{
    private static final String STR_DENUNCIO = 'Denuncio';
    private static final String STR_EVALUACION = 'Evaluación';
    private static final String STR_INGRESO_TALLER = 'Ingreso en Taller';
    private static final String STR_ORDEN_TRABAJO_ENVIADA = 'Orden de trabajo enviada';
    private static final String STR_ENTREGA_VEHICULO = 'Entrega Vehículo';
    
    public HDI_CaseMilestone(List<CaseMilestone> sObjectList) {
        super(sObjectList);
    }
    
    public static void updateCaseMilestone(HDI_Cases cases, Map<Id, Case> mapOld, fflib_SObjectUnitOfWork uow) {
        map<string, CaseMilestone> mapCaseMilestone = new map<string, CaseMilestone>();
        list<CaseMilestone> listCaseMilestoneToUpdate = new list<CaseMilestone>();
        for(CaseMilestone item : new HDI_CaseMilestoneSelector().selectCaseMilestoneByCaseId(cases.Records)){
            mapCaseMilestone.put(item.CaseId + item.MilestoneType.Name, item);
        }
        
        boolean notUpdate = false;
        for(Case cas : (List<Case>) cases.Records) {
            /* if(cas.TipoEvento__c == '100' && !mapCaseMilestone.isEmpty() && mapCaseMilestone.containsKey(cas.id + 'Denuncio Ingresado')){
                listCaseMilestoneToUpdate.add(completeCaseMilestone(mapCaseMilestone.get(cas.id + 'Denuncio Ingresado')));

            }else */ if(cas.TipoEvento__c == '200' && mapOld.get(cas.id).TipoEvento__c != '200'  && mapCaseMilestone.containsKey(cas.id + STR_EVALUACION)){
                listCaseMilestoneToUpdate.add(completeCaseMilestone(mapCaseMilestone.get(cas.id + STR_EVALUACION)));
            
            }else if(cas.TipoEvento__c == '110' && mapOld.get(cas.id).TipoEvento__c != '110' && mapCaseMilestone.containsKey(cas.id + STR_INGRESO_TALLER) ){
                listCaseMilestoneToUpdate.add(completeCaseMilestone(mapCaseMilestone.get(cas.id + STR_INGRESO_TALLER)));
            
            }else if(cas.TipoEvento__c == '400' && mapOld.get(cas.id).TipoEvento__c != '400'  && mapCaseMilestone.containsKey(cas.id + STR_ORDEN_TRABAJO_ENVIADA)){
                listCaseMilestoneToUpdate.add(completeCaseMilestone(mapCaseMilestone.get(cas.id + STR_ORDEN_TRABAJO_ENVIADA)));
            
            }else if(cas.TipoEvento__c == '600' && mapOld.get(cas.id).TipoEvento__c != '600'  && mapCaseMilestone.containsKey(cas.id + STR_ENTREGA_VEHICULO)){
                listCaseMilestoneToUpdate.add(completeCaseMilestone(mapCaseMilestone.get(cas.id + STR_ENTREGA_VEHICULO)));
            }else{
                notUpdate = true;
            }
            uow.registerDirty(cas);
        }
        system.debug(listCaseMilestoneToUpdate);
        if(!notUpdate){
            update listCaseMilestoneToUpdate; 
        }
    }

    static CaseMilestone completeCaseMilestone(CaseMilestone caseM){
        caseM.CompletionDate = system.now();
        return caseM;
    }
}