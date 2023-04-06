@isTest(SeeAllData=true)
public class HDI4I_AsignacionesTest {
    
    public static testMethod void HDI4I_Asignacion_crono(){        
        SchedulableContext sc = null;
        HDI4I_Asignacion_crono tsc = new HDI4I_Asignacion_crono();
        tsc.execute(sc);
    }
    
    public static testMethod void HDI4I_RR_crono(){   
    	HDI4I_RoundRobin_Crono.crono();    
    } 
}