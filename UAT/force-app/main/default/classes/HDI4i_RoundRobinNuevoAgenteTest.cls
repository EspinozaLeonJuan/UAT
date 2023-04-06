@isTest(SeeAllData=true)
private class HDI4i_RoundRobinNuevoAgenteTest {
    public static testMethod void HDI4i_RoundRobinNuevoAgenteTest(){
        User u = [select Id from user limit 1];
        System.runAs(u){
            HDI4i_Cola_round_robin__c cola = new HDI4i_Cola_round_robin__c(
                Name='Test',
                HDI4i_Tipificaci_n_de_caso__c = 'Test',
                HDI4i_N_mero_de_agentes__c = 1
            );
            insert cola;
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
            HDI4i_Agente_en_cola_round_robin__c ag1 = new HDI4i_Agente_en_cola_round_robin__c(
                HDI4i_Cola_round_robin__c = cola.Id,
                HDI4i_Usuario__c = u1.Id
            );
            insert ag1;
            HDI4i_Agente_en_cola_round_robin__c ag2 = new HDI4i_Agente_en_cola_round_robin__c(
                HDI4i_Cola_round_robin__c = cola.Id,
                HDI4i_Usuario__c = u2.Id
            );
            insert ag2;
            delete ag2;
        }        
    }

}