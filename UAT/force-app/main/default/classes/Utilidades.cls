public without sharing class Utilidades {
    
    @AuraEnabled
    public static string resetUserPassword(String userId){
        try {
            System.resetPassword(userId, true);
            return 'Ok';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}