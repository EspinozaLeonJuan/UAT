@isTest(SeeAllData=true)
public class HDI4I_VF_Test {
    
    public static testMethod void HDI4i_VF_User(){
        User u = [SELECT Id, Name FROM User where Profile.Name like '%Admin%' and isActive = true Limit 1];
        MyController m = new MyController();
        m.idd = u.id;
        m.save();
    }
    
    public static testMethod void HDI4i_VF_Opp(){
        HDI4I_ConTest c = new HDI4I_ConTest();
		User u = [SELECT Id, Name FROM User where Profile.Name like '%Admin%' and isActive = true Limit 1]; 
        User u2 = [SELECT Id, Name FROM User where Name =: 'Viviana Millan Becerra'];
        List<SelectOption> se = c.usuarios;
        se = c.stage;
        
        c.pOld = 'Todos';
        c.ss = 'Todos';
        c.buscar();
        c.ss = 'Nuevo';
        c.buscar();
        c.pOld = u.id;
        c.buscar();
        c.ss = 'Todos';
        c.buscar();
        c.oportunidad = [SELECT Id, Name, OwnerId, Owner.Name, stagename, HDI4I_Asignado_Pull__c, HDI4I_Asignacion_VF__c, CreatedDate FROM Opportunity where ownerId =: '0053t000007QVfhAAG' and stagename =: 'Nuevo' order by CreatedDate desc limit 2];
        c.pNew = u2.Id;
        c.asignar();
        c.todas();
        
        c.rut = '15564327k';
        c.buscarRut();
        c.sinAsignar();
        c.todasEj();
        
    }

}