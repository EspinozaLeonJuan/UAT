@isTest
public class BECS_DataFactory {
    
    public static List<HDI4I_Marca__c> createMarcas(Integer num){
        return createMarcasConNombre(num,'BMW','bmw1');
    }  
    
    
    
    public static List<HDI4I_Marca__c> createMarcasConNombre(Integer num,String name,String codigo){	
        List< HDI4I_Marca__c> creadas=new List< HDI4I_Marca__c>();
        
        for(Integer i =0;i<num;i++){
            HDI4I_Marca__c marca = new HDI4I_Marca__c();        
        	marca.Name = name+i;
        	marca.HDI4I_Codigo_de_la_marca__c  = codigo+i;
            creadas.add(marca);
        }
        
        return creadas;
    }  
    
    
    
    public static Map< String, List<sObject> > createModelos(Integer num, HDI4I_Marca__c marca){
        
        return createModelosConNombre(num,marca,'COROLLA','corolla');
    }
    
    
    
      public static Map< String, List<sObject> > createModelosConNombre(Integer num, HDI4I_Marca__c marca, String Name,String code){
        List <HDI4I_Modelo__c> modelos = new List <HDI4I_Modelo__c>();
        Map< String, List<sObject> > creadas = new Map< String, List<sObject> >();
        
        HDI4I_Marca__c nuevaMarca = marca;
        
        // Si se quiere crear marca en createModelos pasar null como marca: createModelos(Num , null)
        if(marca == null){
        	nuevaMarca = createMarcasConNombre(1, 'TOYOTA', 'Toyota')[0];
        }
        
        for(Integer i =0;i<num;i++){
            HDI4I_Modelo__c modelo = new HDI4I_Modelo__c();        
        	modelo.Name = Name+i;
        	modelo.HDI4I_Codigo_del_modelo__c  = code+i;
            modelo.HDI4I_Marca__c=nuevaMarca.id;
            modelos.add(modelo);
        }
        List <HDI4I_Marca__c> marcas = new List<HDI4I_Marca__c>();
        marcas.add(nuevaMarca);
        creadas.put('modelos',modelos);
        creadas.put('marcas',marcas);
        
        return creadas;
    }
    
    
    
	public static List<Account> createAccounts(Integer num){
        List< Account> creadas=new List< Account>();
        
        for(Integer i =0;i<num;i++){
            Account acc = new Account();        
        	acc.LastName = 'LastName '+i;
        	acc.HDI4I_RUT_del_cliente__c  = '2499'+i;
            acc.PersonEmail='emailnumero'+i+'@email.com';
            acc.HDI4I_Digito_verificador_rut_cliente__c=''+math.mod(i,19);
            acc.CurrencyIsoCode='CLF';
            creadas.add(acc);
        }
        
        return creadas;
    }
    
    
    
    public static Map< String, List<sObject> > createLeads(Integer num, HDI4I_Marca__c marca, HDI4I_Modelo__c modelo){
        
        List<Lead> leads = new List<Lead>();
        Map< String, List<sObject> > creados = new Map< String, List<sObject> >();

        HDI4I_Marca__c marcaCreada = marca;
        HDI4I_Modelo__c modeloCreado = modelo;
        Map< String, List<sObject> > marcaYmodelo = new Map< String, List<sObject> >();

        // Si se quiere crear marca y modelo en createLeads pasar null como marca y modelo : createLeads(Num , null, null)
        if (marca == null && modelo == null){
            marcaYmodelo = createModelos(1,null);
            marcaCreada = (HDI4I_Marca__c) marcaYmodelo.get('marcas')[0];
           	modeloCreado = (HDI4I_Modelo__c) marcaYmodelo.get('modelos')[0];
        } 
        
        for(Integer i = 0; i < num ; i++){
            Lead lead = new Lead();
            lead.LastName = 'LastName ' + i;
            lead.Status = 'Nuevo';
            lead.LeadSource = 'VSV2';
            lead.Rut_sin_puntos_y_con_gui_n__c = '13643049-1';
            lead.HDI4I_RUT_del_cliente__c = '13643049-1';
            lead.HDI4I_Digito_verificador_rut_cliente__c = 'K';
            lead.HDI4I_Id_Marca_vehiculo__c = marcaCreada.HDI4I_Codigo_de_la_marca__c;
            lead.HDI4I_Id_Modelo_vehiculo__c = modeloCreado.HDI4I_Codigo_del_modelo__c;
            leads.add(lead);
        }
        
        List <HDI4I_Marca__c> marcas = new List<HDI4I_Marca__c>();
		List <HDI4I_Modelo__c> modelos = new List<HDI4I_Modelo__c>();

        marcas.add(marcaCreada);
        modelos.add(modeloCreado);
        
        
        creados.put('modelos',modelos);
        creados.put('marcas',marcas);
        creados.put('leads',leads);
        
        return creados;
        
    }
    
    
    
    public static List<Account> createPersonAccount(Integer num){
        Id personAccountRecordTypeId =  Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();
        
		List<Account> creadas=new List<Account>();
        
        for(Integer i =0;i<num;i++){
            Account acc = new Account();  
            acc.RecordTypeId = personAccountRecordTypeId;
        	acc.LastName = 'LastName '+i;
        	acc.HDI4I_RUT_del_cliente__c  = '2499'+i;
            acc.PersonEmail='emailnumero'+i+'@email.com';
            acc.HDI4I_Digito_verificador_rut_cliente__c=''+math.mod(i,19);
            acc.CurrencyIsoCode='CLF';
            creadas.add(acc);
        }

        return creadas;
    }
    
    
    
    public static Map< String, List<sObject> > createContacts(Integer num, Account account) {
        
        // REVISAR
        Map< String, List<sObject> > creados = new Map< String, List<sObject> >();
        List<Contact> contacts = new List<Contact>();
        
        Account accountCreada = account;
        
        //Si se quiere crear el Account en createContacts pasar null como account : createContacts(Num, null)
        
        if(account == null) {
            accountCreada = createAccounts(1)[0];
        }
        
        for(Integer i = 0; i < num ; i++){
            Contact contact = new Contact();
            contact.LastName = 'LastName ' + i;
            contact.AccountId = accountCreada.id;
            contacts.add(contact);
        }
        
        List <Account> accounts = new List<Account>();
        accounts.add(accountCreada);
        
        creados.put('accounts',accounts);
        creados.put('contacts',contacts);
        
        return creados;
    }
    
    
    
    public static Map< String, List<sObject> > createOpportunities(Integer num, Account account, HDI4I_Marca__c marca, HDI4I_Modelo__c modelo) {
        
        Map< String, List<sObject> > creadas = new Map< String, List<sObject> >();
        
        List<Opportunity> opportunities = new List<Opportunity>();
        
        Account accountCreada = account;
        
        Map< String, List<sObject> > marcaYmodelo = new Map< String, List<sObject> >();
        HDI4I_Marca__c marcaCreada = marca;
        HDI4I_Modelo__c modeloCreado = modelo;
        
        // Si se quiere crear marca y modelo en createLeads pasar null como marca y modelo : createOpportunities(Num , Account, null, null)
       	if(account == null) {
            accountCreada = createAccounts(1)[0];
        }
        
        //Si se quiere crear el Account en createContacts pasar null como account : createOpportunities(Num, null, Marca, Modelo)
		if (marca == null && modelo == null){
            marcaYmodelo = createModelos(1,null);
            marcaCreada = (HDI4I_Marca__c) marcaYmodelo.get('marcas')[0];
           	modeloCreado = (HDI4I_Modelo__c) marcaYmodelo.get('modelos')[0];
        }
        
        for(Integer i = 0 ; i < num ; i++) {
            Opportunity opp = new Opportunity();
            opp.AccountId =  accountCreada.Id;
            opp.Name = 'Test data ' +i;
            opp.StageName = 'Nuevo';
            opp.HDI4I_Id_Oportunidad_web__c = 'TEST_V1_2022'; 
            opp.HDI4I_Campana_cotizador_web__c = 'Campaña Ejecutivo Banco Estado';
            opp.CloseDate = Date.today().addDays(10);
            opp.HDI4I_Asignado_Pull__c = true; 
            opp.LeadSource = 'VSV2';
            opp.HDI4I_Origen_de_la_oportunidad__c= 'VSV2';
            opp.HDI4I_Id_Marca_vehiculo__c = marcaCreada.HDI4I_Codigo_de_la_marca__c;
            opp.HDI4I_Id_Modelo_vehiculo__c = modeloCreado.HDI4I_Codigo_del_modelo__c;
            opportunities.add(opp);
        }
        
        List <Account> accounts = new List<Account>();        
        List <HDI4I_Marca__c> marcas = new List<HDI4I_Marca__c>();
		List <HDI4I_Modelo__c> modelos = new List<HDI4I_Modelo__c>();

        accounts.add(accountCreada);
        marcas.add(marcaCreada);
        modelos.add(modeloCreado);
        
        creadas.put('accounts',accounts);
        creadas.put('modelos',modelos);
        creadas.put('marcas',marcas);
        creadas.put('opportunities',opportunities);
        
        return creadas;
    }
    
    
    
    public static List<Campaign> createCampaigns(Integer num){
        List<Campaign> campaigns = new List<Campaign>();
        
        for(Integer i = 0 ; i < num ; i++) {
            Campaign campaign = new Campaign();
            campaign.Name = 'Campana '+ i;
            campaign.CurrencyIsoCode = 'CLF';
            campaign.BECS_IdCampanaCotizadorWeb__c = '1234' + i;
            campaign.BECS_DiasCierreOportunidad__c = 5;
            campaigns.add(campaign);
        }
        
        return campaigns;
    }
    
   
    
    public static List<Task> createTasks(Integer num){
        List<Task> tasks = new List<Task>();
  
        for(Integer i = 0 ; i < num ; i++) {
            Task task = new Task();
            task.Subject = 'Asunto ' + i;
            task.Priority = 'Normal';
            task.Status = 'Open';
            tasks.add(task);
        }
        
        return tasks;
    }
    
    
        
    public static List<FinServ__FinancialAccount__c> createFinancialAccounts(Integer num, String recType){
        //TODO -----
        //Se utiliza recType para crear la Financial Account con los record types : IP para Insurance Policy y DB para Datos Bancarios
        List<FinServ__FinancialAccount__c> financialAccounts = new List<FinServ__FinancialAccount__c>();
        
        
        for(Integer i = 0 ; i < num ; i++) {
            
        }
        
        return financialAccounts;
    }
    
    
    public static List<User> createUsers(Integer num, Id ProfileId){    
        List<User> users = new List<User>();
        
        for(Integer i = 0 ; i < num ; i++) {
            User user = new User();
            user.LastName = 'LastName '+ i;
            user.Email = 'test' + i + '@test.com';
            user.Alias = 'Tst'+ i;
            user.Username = 'Username' + i + '@test.com';
            user.CommunityNickname = 'test' + i;
            user.ProfileID = ProfileId;
            user.LanguageLocaleKey = 'en_US';
			user.EmailEncodingKey = 'UTF-8';
            user.LocaleSidKey = 'en_US';
			user.TimeZoneSidKey = 'GMT';
            user.IsActive = true;
        }
        
        return users;
    }
    
    public static List<HDI4I_Estado_ejecutivas_call_center__c> createEstadoEjecutivasCallCenter(List<User> listUsuarios){
        HDI4I_Mantenedor_ejecutiva__c mantenedor = new HDI4I_Mantenedor_ejecutiva__c();
        insert mantenedor;

        List<HDI4I_Estado_ejecutivas_call_center__c> estadoEjecutivasCallCenter = new List<HDI4I_Estado_ejecutivas_call_center__c>();
            
        for(User item : listUsuarios) {
            HDI4I_Estado_ejecutivas_call_center__c ejecutiva = new HDI4I_Estado_ejecutivas_call_center__c();
            ejecutiva.HDI4I_Asignacion__c = false;
            ejecutiva.HDI_Campana__c = 'Ecommerce';
            ejecutiva.HDI4I_Cantidad__c = 0;
            ejecutiva.HDI4I_Ejecutiva__c = UserInfo.getUserId();
            ejecutiva.HDI4I_Ejecutivas_Call_Center__c = mantenedor.id;
            ejecutiva.HDI4I_Estado_de_conexion__c = 'On';
            ejecutiva.HDI4I_On_Off__c = true;
            ejecutiva.HDI4I_Porcentaje_asignacion__c = 10;
            estadoEjecutivasCallCenter.add(ejecutiva);
        }
        
        return estadoEjecutivasCallCenter;
    }
    
}