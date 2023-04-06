global without sharing class SIN_MessageSessionScheduled implements Schedulable{
    
    global void execute(SchedulableContext ctx){

        try {
            String idCtx = ctx.getTriggerId();
            System.abortJob(idCtx);
            
            List<group> defaultQueue = [Select id From group where developername = 'Ejecutivas_Siniestros' limit 1];

            List<MessagingSession> listConversacionesNotificar = [Select id, StartTime 
                                                                    From MessagingSession 
                                                                    Where Status = 'Waiting' AND 
                                                                    OwnerId =: defaultQueue[0].Id AND
                                                                    SIN_MensajeTopeConversaciones__c = False];

            Datetime fechaHoraActual = system.now();

            for (MessagingSession item : listConversacionesNotificar) {
                DateTime newDateTime = item.StartTime.addMinutes(5);
                if (newDateTime < fechaHoraActual) {
                    item.SIN_MensajeTopeConversaciones__c = true;    
                }
            }

            if (!listConversacionesNotificar.isEmpty()) {
                update listConversacionesNotificar;    
            }

        } catch (Exception e) {
            system.debug('SIN_MessageSessionScheduled, error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());    
        }
        crono();
    }

    public static string crono(){
        integer tiempo = 2;

        DateTime myDateTime = system.now();
        DateTime newDateTime = myDateTime.addMinutes(tiempo);
        
        List<String> businessHoursName = new List<String>();
        businessHoursName.add('Siniestros');

        List<Boolean> isCheckBusiness = new List<Boolean>(); 
        isCheckBusiness = CheckBusinessHours.checkBusinessHoursByName(businessHoursName);

        if (isCheckBusiness[0]) {
            
            integer h = integer.valueof(string.valueOf(newDateTime.hour()));
            integer m = integer.valueof(string.valueOf(newDateTime.minute()));
            integer s = integer.valueof(string.valueOf(newDateTime.second()));
            string y = string.valueOf(newDateTime.year());
            string d = string.valueOf(newDateTime.day());
            string mes = string.valueOf(newDateTime.month());
            integer me = m; // + tiempo; No necesario, INETUM
            integer he = 0;
            integer mf = 0;
            integer r = 0;
            string hes = '';
            string mfs = '';
            string ss = '';
            Integer randomNumber = Integer.valueof((Math.random() * 1000000));
            string rn = string.valueOf(randomNumber);

            he = h;
            mf = me;
            
            if(he < 10){
                hes = '0'+he; 
            } else{
                hes = string.valueOf(he);
            }
            if(mf < 10){
                mfs = '0'+mf; 
            } else{
                mfs = string.valueOf(mf);
            }
            if(s < 10){
                ss = '0'+s; 
            } else{
                ss = string.valueOf(s);
            }
            if(he == 24){
                he = 00;
                hes = string.valueOf(he);
            }
            
            system.debug('se actualiza a las: '+he+':'+mf+' del '+d+'/'+mes+'/'+y);
            
            SIN_MessageSessionScheduled o = new SIN_MessageSessionScheduled();
            system.schedule('MessageSessionConversaciones'+rn, '0 '+mf+' '+he+' '+d+' '+mes+' ? '+y, o);        
        }

        return '';
    }
}