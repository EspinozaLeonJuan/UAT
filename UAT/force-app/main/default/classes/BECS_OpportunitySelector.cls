public without sharing class BECS_OpportunitySelector extends fflib_SObjectSelector{
    public  List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Opportunity.Id,
            Opportunity.Name,
            Opportunity.StageName,
            Opportunity.CloseDate,
            Opportunity.AccountId,
            Opportunity.OwnerId,
            Opportunity.BECS_Asegurado__c,
            Opportunity.CampaignId,
            Opportunity.BECS_DatosBancarios__c,
            Opportunity.HDI4I_Campana_cotizador_web__c,
            Opportunity.HDI4I_Dueno_vehiculo__c,
            Opportunity.HDI4I_Deducible__c,
            Opportunity.HDI4I_Auto_reemplazo__c,
            Opportunity.HDI4I_Producto_seleccionado__c,
            Opportunity.HDI4I_Tipo_de_vehiculo__c,
            Opportunity.HDI4I_Correo_asegurado__c,
            Opportunity.HDI4I_Marca__c,
            Opportunity.HDI4I_Modelo__c,
            Opportunity.HDI4I_Digito_verificador_rut_cliente__c,
            Opportunity.HDI4I_Digito_verif_rut_dueno_vehiculo__c,
            Opportunity.HDI4I_Vehiculo_nuevo__c,
            Opportunity.HDI4I_Fecha_envio_cotizacion__c,
            Opportunity.HDI4I_Id_Oportunidad_web__c,
            Opportunity.HDI4I_Oportunidad_gestionada__c,
            Opportunity.HDI4I_Paso_cotizacion_web__c,
            Opportunity.HDI4I_Patente_del_vehiculo__c,
            Opportunity.HDI4I_Prima_cotizo_seguro__c,
            Opportunity.HDI4I_RUT_del_cliente__c,
            Opportunity.HDI4I_RUT_dueno_del_vehiculo__c,
            Opportunity.HDI4I_Numero_contacto__c,
            Opportunity.HDI4I_Vehiculo_tiene_patente__c,
            Opportunity.HDI4I_Ano_del_vehiculo__c,
            Opportunity.HDI4I_Responsabilidad_civil__c,
            Opportunity.HDI4I_Id_Marca_vehiculo__c,
            Opportunity.HDI4I_Id_Modelo_vehiculo__c,
            Opportunity.HDI4I_Tipo_de_pago__c,
            Opportunity.HDI4I_Pago_primera_cuota__c,
            Opportunity.HDI4I_Prioridad__c,
            Opportunity.LeadSource,
            Opportunity.HDI4I_IdTarifa__c,
            Opportunity.HDI4I_Codigo_de_producto_elegido__c,
            Opportunity.HDI4I_Numero_chasis__c,
            Opportunity.HDI4I_Numero_motor__c,
            Opportunity.HDI4I_Banco__c,
            Opportunity.HDI4I_Tipo_tarjeta__c,
            Opportunity.HDI4I_Numero_tarjeta__c,
            Opportunity.HDI4I_Sucursal__c,
            Opportunity.HDI4I_Numero_cuenta__c,
            Opportunity.HDI4I_Numero_transaccion__c,
            Opportunity.HDI4I_Dia_cargo__c,
            Opportunity.BECS_NumeroSimulacion__c,
            Opportunity.LeadSource,
            Opportunity.CurrencyIsoCode,
            Opportunity.FinServ__FinancialAccount__c,
            Opportunity.Account__r.Name,
            Opportunity.GCLID__c
    
        };
    }
    
    public Schema.SObjectType getSObjectType() {
        return Opportunity.sObjectType;
    }
    
    public Map<String, Opportunity> selectByIdWeb(Set<String> setIdWeb) {
        Map<String, Opportunity> mapOpps = new Map<String, Opportunity>();

        for(Opportunity item : Database.query(newQueryFactory().setCondition('HDI4I_Id_Oportunidad_web__c IN: setIdWeb').toSOQL()))
        {
            mapOpps.put(item.HDI4I_Id_Oportunidad_web__c, item);
        }

        return mapOpps;
    }    

    public List<Opportunity> selectById(List<Id> listOpportunityId) {
        fflib_QueryFactory queryFactory = newQueryFactory();
        queryFactory.setCondition('Id IN: listOpportunityId');
        return Database.query( queryFactory.toSOQL() );
    }

    public List<Opportunity> byId(Set<ID> idSet) { 
        List<Opportunity> opp = new List<Opportunity>();
        return (List<Opportunity>) Database.query(newQueryFactory().selectField('Account.Name').
        selectField('Account.personemail').
        selectField('Account.PersonMobilePhone').
        selectField('Account.id').
        selectField('Owner.HDI4I_UsuarioId__c').
        selectField('Owner.HDI4I_VendedorId__c').
        selectField('Owner.HDI4I_usuario__c').
        selectField('Owner.HDI4I_clave__c').
        selectField('Owner.HDI4I_CorredorId__c').setCondition('id IN: idSet').toSOQL());

    } 
}