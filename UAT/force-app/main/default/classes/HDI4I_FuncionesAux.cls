public class HDI4I_FuncionesAux {
    
    public static boolean existeMarca(String idMarca){
        
        List<HDI4I_Marca__c> marca = [Select id from HDI4I_Marca__c where HDI4I_Codigo_de_la_marca__c  =: idMarca];
        if(marca.size() > 0){
            system.debug('Existe marca');
            return true;
        }else{
            system.debug('No existe marca');
            return false;            
        }        
    }
    
    public static boolean existeModelo(String idModelo){
        
        List<HDI4I_Modelo__c> modelo = [Select id from HDI4I_Modelo__c where HDI4I_Codigo_del_modelo__c =: idModelo];
        if(modelo.size() > 0){
            return true;
        }else{
            return false;
        }  
    }
    
    public static String crearMarca(String nombreMarca, String codigoMarca){
        HDI4I_Marca__c marca = new HDI4I_Marca__c();
        
        marca.Name = nombreMarca;
        marca.HDI4I_Codigo_de_la_marca__c  = codigoMarca;
        
        try{
            insert marca;
            
            
        }catch(DmlException x){
            System.debug('ERROR: '+x.getMessage());
        }
        
        return marca.id;
    }
    
    public static String crearModelo(string idMarca, String nombreModelo, String codigoModelo){
        HDI4I_Marca__c marca = [Select id from HDI4I_Marca__c where HDI4I_Codigo_de_la_marca__c =: idMarca];
        
        HDI4I_Modelo__c modelo = new HDI4I_Modelo__c();
        modelo.Name = nombreModelo;
        modelo.HDI4I_Codigo_del_modelo__c = codigoModelo;
        modelo.HDI4I_Marca__c = marca.id;
        
        try{
            insert modelo;
        }catch(DmlException x){
            System.debug('Error: '+x.getMessage());
        }
        
        return modelo.id;
    }
    
    public static String llamarMarca(String idMarca){
        HDI4I_Marca__c marca = [Select id from HDI4I_Marca__c where HDI4I_Codigo_de_la_marca__c =: idMarca];
        return marca.id;
    }
    
    public static String llamarModelo(String idModelo){
        HDI4I_Modelo__c modelo = [Select id from HDI4I_Modelo__c where HDI4I_Codigo_del_modelo__c =: idModelo];
        return modelo.id;
    }

}