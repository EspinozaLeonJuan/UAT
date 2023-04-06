public with sharing class HDI_ApiResponseWrapper {
    public list<ERROR> listError {get; set;}
    public list<SUCCESS> listSuccess {get; set;}

    public class ERROR{
        public Integer codigo {get; set;}
        public String mensaje {get; set;}
        public string numeroSiniestro {get; set;}

        public ERROR(String mensaje, String numeroSiniestro, Integer codigo){
            this.codigo = codigo;
            this.mensaje = mensaje;
            this.numeroSiniestro = numeroSiniestro;
        }
    }
    public class SUCCESS{
        public String mensaje {get; set;}
        public string numeroSiniestro {get; set;}
        public Integer codigo {get; set;}

        public SUCCESS(String identifier, String numeroSiniestro, Integer codigo){            
            this.mensaje=identifier;
            this.numeroSiniestro = numeroSiniestro;
            this.codigo = codigo;
        }
    }
    public HDI_ApiResponseWrapper(list<ERROR> listErr, list<SUCCESS> listSucc) {
        this.listError = listErr;
        this.listSuccess = listSucc;
    }
    public HDI_ApiResponseWrapper() { }
    
    public Map<String, Object> toMap() {
        Map<String, Object> responseMap = new Map<String, Object>();
        List<Object> successList = new List<Object>();
        List<Object> errorList = new List<Object>();
        
        for (SUCCESS success : this.listSuccess) {
            Map<String, Object> successMap = new Map<String, Object>();
            successMap.put('codigo', success.codigo);
            successMap.put('numeroSiniestro', success.numeroSiniestro);
            successMap.put('mensaje', success.mensaje);
            successList.add(successMap);
        }
        
        for (ERROR error : this.listError) {
            Map<String, Object> errorMap = new Map<String, Object>();
            errorMap.put('codigo', error.codigo);
            errorMap.put('numeroSiniestro', error.numeroSiniestro);
            errorMap.put('mensaje', error.mensaje);
            errorList.add(errorMap);
        }
        
        responseMap.put('listSuccess', successList);
        responseMap.put('listError', errorList);
        
        return responseMap;
    }
}