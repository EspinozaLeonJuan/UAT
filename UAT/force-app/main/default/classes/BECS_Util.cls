public without sharing class BECS_Util {
    
    public static String validateEmail(String email){
        String emailRegex = '^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$'; 

        if(String.isEmpty(email)){
            return email;
        }
        return !Pattern.compile(emailRegex).matcher(email).matches() ? '' : email;
    }

}