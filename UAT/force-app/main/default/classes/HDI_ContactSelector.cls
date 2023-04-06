/**********************************************************************
 Name:  HDI_ContactSelector()
 Copyright © 2021  INETUM
 ======================================================
======================================================
Purpose:                                                            
Contact Selector Handle SOQL for Contact                                                          
======================================================
======================================================
History                                                            
-------                                                            
VERSION  AUTHOR            DATE              DETAIL            Description
   1.0   Fran Oseguera   19/10/2021      INITIAL DEVELOPMENT    CSR: 
***********************************************************************/
public with sharing class HDI_ContactSelector extends fflib_SObjectSelector{

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Contact.Id,
            Contact.Rut_sin_puntos_y_con_gui_n__c,
            Contact.Email,
            Contact.MobilePhone,
            Contact.LastName,
            Contact.FirstName
        };
    }

    public Schema.SObjectType getSObjectType() {
        return Contact.sObjectType;
    }
    
    public List<Contact> selectByRut(Set<String> rutSet) {
        return (List<Contact>) Database.query(
            newQueryFactory().
            setCondition('Rut_sin_puntos_y_con_gui_n__c IN: rutSet').
            toSOQL()
        );
    }
}