@isTest(SeeAllData=true)
public class HDI4i_invitaEncuestaPostChatCtrTest {
    public static testMethod void testMyController() {
        LiveChatVisitor vis = new LiveChatVisitor();
        insert vis;
        LiveChatTranscript chat = new LiveChatTranscript(
            HDI41_Invitaci_n_a_encuesta__c=null,
            LiveChatVisitorId=vis.Id
        );
        insert chat;
        Survey e = [select Id, developername from Survey Where Name='Encuesta post chat' LIMIT 1];
        
        Test.startTest();
            PageReference pageRef = Page.HDI4i_invitaEncuestaPostChat; 
 	    	PageRef.getParameters().put('chatkey', String.valueOf(chat.chatkey));
 	    	PageRef.getParameters().put('vinculoFinal', 'https://chatcenter-01.cs21.force.com/CC/survey/runtimeApp.app?invitationId=0Kiq00000008b4x&surveyName=encuesta_post_chat&UUID=13af1130-3217-4a54-8320-0683d0c6d3d3');
 	    	PageRef.getParameters().put('vinculoEncuesta', 'https://chatcenter-01.cs21.force.com/CC/survey/runtimeApp.app?invitationId=0Kiq00000008b4x&surveyName=encuesta_post_chat&UUID=13af1130-3217-4a54-8320-0683d0c6d3d3');
            Test.setCurrentPage(pageRef);
        	HDI4i_invitaEncuestaPostChatCtr pageTest = new HDI4i_invitaEncuestaPostChatCtr();
        Test.stopTest();
 
    }
}