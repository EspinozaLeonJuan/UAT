@isTest(SeeAllData=true)
public class MetodosTest {
    
    public static testMethod void correo(){
        
        User u = [Select id, HDI4I_on_off__c from User where id =: '0053t000007QVfhAAG'];
        
        if(u.HDI4I_on_off__c == true){
            u.HDI4I_on_off__c = false;
        }else{
            u.HDI4I_on_off__c = true;
        }
        update u;
        
    }

}