/**********************************************************************
     Name:  HDI_CaseSelector()
    Copyright © 2023  INETUM
    ======================================================
    ======================================================
    Purpose:                                                            
    Cases Selector Handle SOQL for Case                                                          
    ======================================================
    ======================================================
    History                                                            
    -------                                                            
    VERSION  AUTHOR            DATE              DETAIL            Description
    1.0   Jeff Velasquez  07/03/2023      SINIESTROS SIN        Siniestros     
    ***********************************************************************/
    @RestResource(urlMapping='/caso/siniestro/*')
    
    global class HDI_APISiniestrosRoute_SIN {
        
        global  static void handleRequest() {
            HDI_ApiSiniestros_SIN apiReq =  new HDI_ApiSiniestros_SIN();
            apiReq.execute();
        }

        @HttpGet
        global static void handleGet() {
            handleRequest();
        }

        @HttpPost
        global static void handlePost() {
            handleRequest();
        }

        @HttpPut
        global static void handlePut() {
            handleRequest();
        }

        @HttpDelete
        global static void handleDelete() {
            handleRequest();
        }

    }