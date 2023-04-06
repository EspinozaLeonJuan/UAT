@isTest(SeeAllData=true)
public class HDI4i_invitaEncuestaChatTest {
    static testmethod void test(){
        String vinculoEncuesta;
        String comunidadNombre='Chat Center';
        String claveDeChat;
        Network comunidad = [select id,name from network where name='Chat Center' LIMIT 1];
        Survey encuesta = [select Id from Survey Where Name='Encuesta post chat' LIMIT 1];
        LiveChatVisitor vis = new LiveChatVisitor(
        );
        insert vis;
        LiveChatTranscript chat = new LiveChatTranscript(
            HDI41_Invitaci_n_a_encuesta__c=null,
            LiveChatVisitorId=vis.Id
        );
        insert chat;
        
        String chatJSON = '{"attributes":{"type":"LiveChatTranscript","url":"/services/data/v51.0/sobjects/LiveChatTranscript/'+chat.id+'"},"Id":"'+chat.id+'","Status":"Waiting","Body":"Hola a todos!"}';
        LiveChatTranscript c = (LiveChatTranscript) JSON.deserialize(chatJSON, LiveChatTranscript.class); 
        system.debug('c.Status = '+c.Status);
        system.debug('c.HDI41_Invitaci_n_a_encuesta__c = '+c.HDI41_Invitaci_n_a_encuesta__c);
        
        Id res=c.id;
        LiveChatTranscript chat2=[select id,body, Status ,HDI41_Invitaci_n_a_encuesta__c from LiveChatTranscript where id=:res];
        chat2.Body='test';
        chat2.HDI41_Invitaci_n_a_encuesta__c=null;
        System.debug('chat2 status: '+chat2.Status);
        System.debug('chat2 body: '+chat2.body);
        update chat2;
    }
}