trigger CaseTrigger2 on Case (before insert, after insert) {
	
    if(Trigger.isAfter && Trigger.isInsert){
        for(Case c: Trigger.new){
            if(c.HDI4I_VF__c == True){
                correosCasos.semilla(Trigger.new);
            }
        }
        
    }
    
}