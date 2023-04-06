public class HDI_MessagingSession{
  
  public static void onAfterUpdate(List<MessagingSession> mSes) {

      for(MessagingSession  item : (List<MessagingSession>) mSes){
          if(item.status == 'Ended'){
              Case caso = [SELECT suppliedEmail from Case WHERE id=: item.CaseId];

              System.debug(caso);


          }
      }
  }


}
/*  public without sharing class HDI_MessagingSession extends  fflib_SObjectDomain{
      public HDI_MessagingSession(List<MessagingSession> sObjectList) {
        super(sObjectList);
    }
    
    public override void onAfterUpdate(Map<Id, SObject> sObjectMap) {

        for(MessagingSession  item : (List<MessagingSession>) Records){
            if(item.status == 'Ended'){
                Case caso = [SELECT suppliedEmail from Case WHERE id=: item.CaseId];

                System.debug(caso);




            }
        }
    }
    


}*/