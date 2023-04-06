trigger HDI4I_ConvierteLeadCalificado on Lead (after insert, after update) {
	/*
	 * HDI 4I TRIGGER CONVIERTE LEAD CALIFICADO
	 * APLICACIÓN: INSTANT CALL
	 * Trigger sobre Lead (Prospecto) que evalúa si el lead de Instant Call está calificado y viene de VSV2
	*/
    for(Lead este : Trigger.new){
        if(este.Status == 'Calificado' && !este.IsConverted && este.LeadSource == 'VSV2') {
            //Si el lead está calificado (por flow "Activa Trigger Conversión") y cuyo origen es VSV2 (por integración con VSV2)
            //Entra a la conversión y asigna un nombre de oportunidad provisorio
            Database.LeadConvert lc = new database.LeadConvert();
            lc.setLeadId(este.Id);
            lc.convertedStatus = 'Qualified';
            String oppName =  este.Name;
            lc.setOpportunityName(oppName);
            LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
            lc.setConvertedStatus(convertStatus.MasterLabel);
            Database.LeadConvertResult lcr = Database.convertLead(lc);
            System.assert(lcr.isSuccess());
        }
    }
}