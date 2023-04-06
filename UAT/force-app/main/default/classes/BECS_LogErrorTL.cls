public without sharing class BECS_LogErrorTL extends fflib_SObjectDomain{

    public BECS_LogErrorTL(List<ORG_IntegrationLogError__c> sObjectList) {
        super(sObjectList);
    }
    
    public void insertLogs(List<ORG_IntegrationLogError__c> listLogs){
        try {
            Database.insert(listLogs, false);

        }catch (Exception e) {
            System.debug(LoggingLevel.DEBUG, 'BECS_LogErrorTL: ' + e.getMessage());    
        }
    }


    public static ORG_IntegrationLogError__c fullLog(String name, BECS_OpportunityAPI.InParameters request, String estado, String errorMessage, HDI_ApiSiniestroJSON siniestro){
        ORG_IntegrationLogError__c logError = new ORG_IntegrationLogError__c();

        List<ORG_IntegrationLogError__c> agr = new List<ORG_IntegrationLogError__c>();

        logError.name = name;
        logError.ORG_FechaHoraError__c = Datetime.now();
        logError.ORG_DescriptionError__c = errorMessage;
        logError.ORG_Estado__c = estado;

        if (request.idHdiOpWeb == null) {
            System.debug('ENTRA IF = SINIESTRO');
            logError.ORG_Proyecto__c = 'Gestion de Siniestros';
            logError.ORG_Solicitud__c = System.JSON.serialize(siniestro);
            logError.ORG_IdOportunidadWeb__c = siniestro.numeroSiniestro;
            logError.ORG_CampanaCotizadorWeb__c = siniestro.idInvolucrado;
        } else {
            System.debug('NO ENTRA = INSTANT CALL');
            logError.ORG_Proyecto__c = 'Instant Call';
            logError.ORG_Solicitud__c = System.JSON.serialize(request);
            logError.ORG_IdOportunidadWeb__c = request.idHdiOpWeb;
            logError.ORG_CampanaCotizadorWeb__c = request.campaniaCotizadorWeb;
        }


        return logError;
    }




}