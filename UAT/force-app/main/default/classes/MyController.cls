public class MyController {

    private final User myAccount;
	//public boolean e {get; set;}
    public string idd {get;set;}
    public MyController() {
        this.idd = UserInfo.getUserId();
        //this.id2 = ApexPages.currentPage().getParameters().get('id');
        myAccount = [SELECT Id, Username, HDI4I_on_off__c  FROM User 
                   WHERE Id = :idd];
    }

    public User getAccount() {
        return myAccount;
    }

    public PageReference save() {        
        system.debug(myAccount.HDI4I_on_off__c);
        update myAccount;
        return null;
    }
}