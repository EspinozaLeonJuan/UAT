@isTest
public class HDI4I_ConvierteLeadCalificado_test {
    public TestMethod static void HDI4I_ConvierteLeadCalificado_test(){
        Lead le = new Lead();
        le.LastName = 'test';
        le.LeadSource = 'VSV2';
        le.Status = 'Calificado';
        le.Rut_sin_puntos_y_con_gui_n__c = '13643049-1';
        le.HDI4I_Id_Marca_vehiculo__c = '538';
        le.HDI4I_Id_Modelo_vehiculo__c = '538012';
        le.HDI4I_RUT_del_cliente__c = '13643049-1';
        le.HDI4I_Auto_reemplazo__c = '30 Días';
        le.HDI4I_Ano_del_vehiculo__c = '2017';
        le.HDI4I_Campana_cotizador_web__c = 'Campaña VSV Agosto JGI';
        le.HDI4I_Codigo_de_producto_elegido__c = '662';
        le.HDI4I_Deducible__c = '3 UF';
        le.HDI4I_Digito_verificador_rut_cliente__c = 'K';
        le.HDI4I_Digito_verif_rut_dueno_vehiculo__c = 'K';
        le.HDI4I_Fecha_envio_cotizacion__c = system.now();
        le.HDI4I_Hora_cronometro__c = '20:18:08:939';
        le.HDI4I_Id_Oportunidad_web__c = '2022_15176715_CHERY_FULWIN_2017';
        le.HDI4I_IdTarifa__c = '';

        Test.startTest();
        insert le;
        Test.stopTest();
    }
}