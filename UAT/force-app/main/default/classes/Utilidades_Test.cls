@isTest
public with sharing class Utilidades_Test {
    
    @IsTest
    static void resetUserPassword(){
        
        Test.startTest();
            string resetUserPassword =  Utilidades.resetUserPassword(UserInfo.getUserId());

            try {
                resetUserPassword =  Utilidades.resetUserPassword(UserInfo.getFirstName());    
            } catch (Exception e) {
                
            }
            
        Test.stopTest();
        
    }
}