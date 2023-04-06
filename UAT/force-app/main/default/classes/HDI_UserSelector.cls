/**********************************************************************
 Name:  HDI_UserSelector()
 Copyright © 2021  INETUM
 ======================================================
======================================================
Purpose:                                                            
User Selector Handle SOQL for User                                                          
======================================================
======================================================
History                                                            
-------                                                            
VERSION  AUTHOR            DATE              DETAIL            Description
   1.0   Fran Oseguera   19/10/2021      INITIAL DEVELOPMENT    CSR: 
***********************************************************************/
public with sharing class HDI_UserSelector extends fflib_SObjectSelector{

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            User.Id,
            User.HDI4I_LiquidadorId__c
        };
    }

    public Schema.SObjectType getSObjectType() {
        return User.sObjectType;
    }
    
    public List<User> selectByLiquidadorId(Set<String> liquidadorIdSet) {
        return (List<User>) Database.query(
            newQueryFactory().
            setCondition('HDI4I_LiquidadorId__c IN: liquidadorIdSet AND isActive = True').
            toSOQL()
        );
    }

    public List<User> selectByFuncion(String nombreFuncion) {
        return (List<User>) Database.query(
            newQueryFactory().
            setCondition('UserRole.Name =: nombreFuncion AND isActive = True').
            toSOQL()
        );
    }
}