@isTest(SeeAllData=true)
private class HDI4i_RoundRobinTest {
    public static testMethod void HDI4i_RoundRobinTest(){
        //crear registros
        User u = [select Id from user limit 1];
        System.runAs(u){
	        Profile perfil = [SELECT Id FROM Profile WHERE Name='Administrador del sistema']; 
            User u1 = new User(
                Username='RRtest1@hdi.cl',
                Alias='RRtest1',
                LastName='Test1',
                Email='RRtest1@hdi.cl',
                TimeZoneSidKey='America/Los_Angeles',
                LocaleSidKey='en_US',
                EmailEncodingKey='UTF-8',
                ProfileId=perfil.Id,
                LanguageLocaleKey='en_US'
            );
            insert u1;
            User u2 = new User(
                Username='RRtest2@hdi.cl',
                Alias='RRtest2',
                LastName='Test2',
                Email='RRtest2@hdi.cl',
                TimeZoneSidKey='America/Los_Angeles',
                LocaleSidKey='en_US',
                EmailEncodingKey='UTF-8',
                ProfileId=perfil.Id,
                LanguageLocaleKey='en_US'
            );
            insert u2;
            HDI4i_Cola_round_robin__c cRR = new HDI4i_Cola_round_robin__c(
                Name='Test',
                HDI4i_Tipificaci_n_de_caso__c ='Renuncia al producto',
                HDI4i_N_mero_de_agentes__c =1
            );
            insert cRR;
            HDI4i_Agente_en_cola_round_robin__c a1 = new HDI4i_Agente_en_cola_round_robin__c(
                HDI4i_Cola_round_robin__c = cRR.Id,
                HDI4i_Usuario__c = u1.Id
            );
            insert a1;
            HDI4i_Agente_en_cola_round_robin__c a2 = new HDI4i_Agente_en_cola_round_robin__c(
                HDI4i_Cola_round_robin__c = cRR.Id,
                HDI4i_Usuario__c = u2.Id
            );
            insert a2;
            
            Case c1 = new Case(
                Status='Nuevo',
                Origin='Email',
                Reason='Renuncia al producto'
            );
            insert c1;
            Case c2 = new Case(
                Status='Nuevo',
                Origin='Email',
                Reason='Renuncia al producto'
            );
            insert c2;
            Case c3 = new Case(
                Status='Nuevo',
                Origin='Email',
                Reason='Renuncia al producto'
            );
            insert c3;
        }
    }
}