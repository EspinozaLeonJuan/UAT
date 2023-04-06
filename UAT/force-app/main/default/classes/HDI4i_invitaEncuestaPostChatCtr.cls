public class HDI4i_invitaEncuestaPostChatCtr {
    public String vinculoEncuesta {get;set;} 
    public String vinculoFinal {get;set;} 
    public HDI4i_invitaEncuestaPostChatCtr() {
        String comunidadNombre='Chat Center';
        String url='';
        String vinculo='';
        String claveDeChat='';
        String invitacion = [select HDI41_Invitaci_n_a_encuesta__c from LiveChatTranscript where ChatKey = : ApexPages.currentPage().getParameters().get('chatKey')].HDI41_Invitaci_n_a_encuesta__c;
        list<LiveChatTranscript> chk = [select chatkey from LiveChatTranscript where ChatKey = : ApexPages.currentPage().getParameters().get('chatKey') limit 1];
        for(LiveChatTranscript chake : chk) {
            claveDeChat=chake.ChatKey;
        }
        Survey encuesta = [select Id, developername from Survey Where Name='Encuesta post chat' LIMIT 1];
        domainsite dominio = [select domainid from domainsite where pathprefix = '/CC/s' limit 1 ];
        domain d = [select domain from domain where id =: dominio.domainid limit 1];
        network n = [select urlpathprefix from network where name =: comunidadNombre limit 1];

		vinculo='https://'+d.domain+'/'+n.urlpathprefix+'/survey/runtimeApp.app?invitationId='+invitacion+'&surveyName='+encuesta.developername+'&UUID='+claveDeChat;        
        /*List<SurveyInvitation> suI = [SELECT InvitationLink, id, HDI4i_Transcripci_n_de_chat__c FROM SurveyInvitation];
        Map<String,SurveyInvitation> msuI = new Map<String,SurveyInvitation>();
        for(SurveyInvitation s : suI){
            msuI.put(s.id, s);
        }
        if(msuI.containsKey(invitacion)){
           url = msuI.get(invitacion).InvitationLink;
        }else{
            url='';
        }*/
        List<SurveyInvitation> suI2 = [SELECT InvitationLink, id, HDI4i_Transcripci_n_de_chat__c FROM SurveyInvitation where id =: invitacion];
        if(suI2.size()>0){
            url = suI2[0].InvitationLink;
        }else{
            url='';
        }
		system.debug('Esta es la url que se envía: '+url);
        Network comunidad = [select id,name from network where name='Chat Center' LIMIT 1];
        vinculoEncuesta='https://chatcenter-01.cs21.force.com/CC/survey/runtimeApp.app?invitationId=0Kiq00000008b4x&surveyName=encuesta_post_chat&UUID=13af1130-3217-4a54-8320-0683d0c6d3d3';
        this.vinculoEncuesta=url;
    }
	public PageReference redirectToSurvey() {
		String url = [SELECT Id, HDI4I_URL_de_la_invitaci_n__c, ChatKey FROM LiveChatTranscript WHERE ChatKey = : ApexPages.currentPage().getParameters().get('chatKey')].HDI4I_URL_de_la_invitaci_n__c;
		PageReference surveyURL = new PageReference(url);
        return surveyURL;
    }
}