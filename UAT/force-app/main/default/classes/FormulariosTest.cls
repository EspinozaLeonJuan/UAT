@isTest
public class FormulariosTest {
    @isTest
    public static void form(){
        
        Case cc = new Case();
        cc.Status = 'Nuevo';
        cc.Origin = 'Web';
        insert cc;
        
        Attachment att = new Attachment();
        
        att.Name = 'Configuración Postman Siniestros.txt';
        att.ContentType = 'text/plain';
        att.Body = EncodingUtil.Base64Decode(base());
        att.ParentId = cc.id;
        insert att;
        
        system.debug('Este es esl id: '+att.id);
        system.debug('Este es el body nuevo: '+String.valueof(att.Body));
        
        string body2 = string.valueOf(att.Body);
        
        CaseControllerExt.attachBlob('parentId', '', 'fileName', 'contentType', 'base64BlobValue', j());
        
        CaseControllerExt.attachBlob('parentId', att.id, att.Name, att.ContentType, base(), j());
        
        CaseControllerExtPerdida.attachBlob('parentId', '', 'fileName', 'contentType', 'base64BlobValue', j2());
        
        CaseControllerExtPerdida.attachBlob('parentId', 'dsf', 'fileName', 'contentType', 'base64BlobValue', j2());
        
        //PageReference p1 = page.ReclamoDevolucionCliente;
        //PageReference p2 = page.ReclamoDevolucionCorredores;
        PageReference p3 = page.ReclamoPerdidaCliente;
        PageReference p4 = page.ReclamoPerdidaCorredor;
        //Test.setCurrentPage(p1);
        //Test.setCurrentPage(p2);
        
        Test.setCurrentPage(p3);
        ApexPages.currentPage().getParameters().put('name', 'test name');
        ApexPages.StandardController sc = new ApexPages.StandardController(cc);
        CaseControllerExt inst = new CaseControllerExt(sc);

        Test.setCurrentPage(p4);
        CaseControllerExtPerdida inst2 = new CaseControllerExtPerdida(sc);
        
        system.debug(j());
    }
    public static String j(){
        
        String json = 
            '{"nombre":"Administrador","rut":"17491727-2","codCorredor":"123123","nombreCorredor":"123123","telefono":"+56950301030","email":"sdfs@sdf.cl","asunto":"prueba","motivo":"Renuncia al producto","descripcion":"asfsfg","nombrePagador":"Felipe","rutPagador":"7630334-7","banco":"Banco de Chile","tipoCuenta":"Cuenta vista","nCuenta":"123123","emailConfirmacion":"sdfs@sdf.cl","nSiniestro":"Cuenta vista","relacionA":"Cuenta vista","subTipo":"Devolución Corredores"}';
        return json;
    }
    
    public static string j2(){
        String json = '{"id":"500P000000A2givIAB","nombre":"Endodoncia","rut":"17491727-2","codCorredor":"asdf","nombreCorredor":"Prueba","telefono":"+56988770099","email":"sdfs@sdf.cl","asunto":"prueba","motivo":"Endodoncia","descripcion":"adfsfgg","nombrePagador":"Endodoncia","rutPagador":"Endodoncia","banco":"Endodoncia","tipoCuenta":"Endodoncia","nCuenta":"Endodoncia","emailConfirmacion":"Endodoncia","nSiniestro":"12334","relacionA":"Familiar","motivoPerdida":"Pago pérdida total","subTipo":"Pérdida total corredor"}';
    	return json;
    }
    public static String base(){
        string b = 'T0JURU5FUiBUT0tFTiBERSBTRUdVUklEQUQNCg0KVGlwbyBkZSBwZXRpY2nDs246IFBPU1QgDQpVUkwgZGUgZW52w61vOiBodHRwczovL3Rlc3Quc2FsZXNmb3JjZS5jb20vc2VydmljZXMvb2F1dGgyL3Rva2VuDQoNCkNvbXBsZXRhciB1biBmb3JtLWRhdGEgY29uIGxvcyBzaWd1aWVudGVzIGRhdG9zOg0KDQoJY2xpZW50X2lkOjNNVkc5Q3h3YmRWNjhxSklLeTRYSUhrQ01yOFhlN0REYy5xVDdxZlAydTVnV29GV0thX0NoT0tHaVZKaUtib2tNUXg5V2p0dFk2d3pJODhSVWpSekcNCglncmFudF90eXBlOnBhc3N3b3JkDQoJY2xpZW50X3NlY3JldDoxMDI3MEI2NTUxMTAzMjU2QjcxQzhBNTBENTRGRDY3QThEQjlDNzdDQjhCMTMwMjVGMjYxNjg0N0U1QUY0MjhEDQoJdXNlcm5hbWU6Y29uc3VsdG9yQGN1YXRyb2kuY29tLnNpbmlzdHJvcw0KCXBhc3N3b3JkOlBydGsxOTQ1MlFQalpvRFBMSDViRUFJd3lmendDRU5lDQoNCkFsIGVudmlhciBlbCBmb3JtLWRhdGEgc2UgZGViZXLDrWEgcmVjaWJpciBlbCBzaWd1aWVudGUgUmVzcG9uc2U6DQoNCgl7DQogICAgCSAgICJhY2Nlc3NfdG9rZW4iOiAiMDBEMFUwMDAwMDBJQzFqIUFSa0FRTzhGUjlvcVZEVjVDU0JBMUdiR0JRMzZoMGdCSUU3Uko4ZUJQMnZ1S292Uk9SbUIwWTdPNlBCM2h5STBaRG15RlZOTnlKNjRuVjRqaUpMRTVsNlkxVlRjSzNMRiIsDQogICAgCSAgICJpbnN0YW5jZV91cmwiOiAiaHR0cHM6Ly9oZGlzZWd1cm9zMS0tc2luaXN0cm9zLm15LnNhbGVzZm9yY2UuY29tIiwNCiAgICAJICAgImlkIjogImh0dHBzOi8vdGVzdC5zYWxlc2ZvcmNlLmNvbS9pZC8wMEQwVTAwMDAwMElDMWpVQUcvMDA1M3QwMDAwMDdRVmZoQUFHIiwNCiAgICAJICAgInRva2VuX3R5cGUiOiAiQmVhcmVyIiwNCiAgICAJICAgImlzc3VlZF9hdCI6ICIxNjE5MTIwOTI3NzQyIiwNCiAgICAJICAgInNpZ25hdHVyZSI6ICJSWnl3Mnl5c0pQMGJtRFAwV1dtY0s3WjhBWnhDKzY1YTVMSXdFbE53V1JRPSINCgl9DQpEZWwgUmVzcG9uc2Ugc2UgdXRpbGl6YXLDoSBlbCAiYWNjZXNzX3Rva2VuIiB5IGVsICJ0b2tlbl90eXBlIi4NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpFTlZJQVIgSlNPTiBBIFNBTkRCT1gNCg0KVGlwbyBkZSBwZXRpY2nDs246IFBPU1QgDQpVUkwgZGUgZW52w61vOiBodHRwczovL2hkaXNlZ3Vyb3MxLS1zaW5pc3Ryb3MubXkuc2FsZXNmb3JjZS5jb20vc2VydmljZXMvYXBleHJlc3QvY2FzZQ0KDQoidG9rZW5fdHlwZSI6IE11ZXN0cmEgZWwgdGlwbyBkZSBhdXRvcml6YWNpw7NuLg0KU2UgZGViZSB1dGlsaXphciBlbCAiYWNjZXNzX3Rva2VuIiBkZWwgUmVzcG9uc2UgcGFyYSBwb2RlciBlbnZpYXIgbG9zIGRhdG9zDQoNCkVqZW1wbG86DQoJIkF1dGhvcml6YXRpb24iOiANCgkgICBUaXBvOiBCZWFyZXIuIA0KCSAgIFRva2VuOiAwMEQwVTAwMDAwMElDMWohQVJrQVFPOEZSOW9xVkRWNUNTQkExR2JHQlEzNmgwZ0JJRTdSSjhlQlAydnVLb3ZST1JtQjBZN082UEIzaHlJMFpEbXlGVk5OeUo2NG5WNGppSkxFNWw2WTFWVGNLM0xGDQoNClNlIGRlYmUgZW52aWFyIGVuIGVsIEJvZHkgZWwgSlNPTiB5IGNvbW8gUmVzcG9uc2Ugc2UgZGViZXLDrWEgcmV0b3JuYXIgdW4gbWVuc2FqZSBqdW50byBhbCBJZCBEZW51bmNpbyAoRXN0ZSBtZW5zYWplIHBvZHLDrWEgdmFyaWFyKQ0KDQoJIkRhdG9zIHJlY2liaWRvcyBjb24gw6l4aXRvIGRlbCBzaWd1aWVudGUgTsKwIGRlIGRlbnVuY2lvOiAyMjI5MDY2Ig0KDQpFbCBCb2R5IHNlcsOtYSBlbCBKU09OIHNpZ3VpZW50ZToNCg0Kew0KICAgICJpZERlbnVuY2lvIjogIjIyMjkwNjYiLA0KICAgICJlc3RhZG9EZW51bmNpbyI6ICJFdmFsdWFkbyIsDQogICAgIm51bWVyb1Npbmllc3RybyI6ICIzMjI1MjIzIiwNCiAgICAicG9saXphIjogIjMtMzM3NC0zNzk1MzItMiIsDQogICAgInJhbW8iOiAiMyIsDQogICAgImRlc2NyaXBjaW9uUmFtbyI6ICJWRUhJQ1VMT1MgTU9UT1JJWkFET1MiLA0KICAgICJwcm9kdWN0byI6ICIzMzc0IiwNCiAgICAiZGVzY3JpcGNpb25Qcm9kdWN0byI6ICJWTSBIREkgRlVMTCBDT01FUkNJTyIsDQogICAgInBvbGl6YV8xIjogIjM3OTUzMiIsDQogICAgImNlcnRpZmljYWRvIjogIjIiLA0KICAgICJmZWNoYU9jdXJyZW5jaWEiOiAiMjAtMTEtMjAyMSAgMTI6NDU6MDAiLA0KICAgICJmZWNoYURlbnVuY2lhIjogIjMwLTExLTIwMjAgIDEyOjQ1OjAwIiwNCiAgICAiY2FuYWxEZW51bmNpYSI6ICJDb3JyZWRvciBJbnRlcm5ldCIsDQogICAgInJ1dEFzZWd1cmFkbyI6ICI2OTI1MzEwMC0wIiwNCiAgICAibm9tYnJlQXNlZ3VyYWRvIjogIkkuTVVOSUNJUEFMSURBRCBSSU8gSUJBw5FFWiIsDQogICAgImNlbHVsYXJBc2VndXJhZG8iOiAiNTY2NzQyMjMyMTYiLA0KICAgICJtYWxsQXNlZ3VyYWRvIjogImZpbmFuemFzZGFlbUByaW9pYmFuZXouY2wiLA0KICAgICJydXRDb25kdWN0b3IiOiAiMTIzMTA4MzctSyIsDQogICAgIm5vbWJyZUNvbmR1Y3RvciI6ICJNQVJDT1MgIFVMTE9BICBTQUxESVZJQSIsDQogICAgIm1hcmNhIjogIk1JVFNVQklTSEkiLA0KICAgICJtb2RlbG8iOiAiTDIwMCIsDQogICAgImFuaW8iOiAiMjAxNyIsDQogICAgInBhdGVudGUiOiAiSkdTTDIyIiwNCiAgICAiaWRMaXF1aWRhZG9yIjogIjMzNjY2IiwNCiAgICAibGlxdWlkYWRvciI6ICJWSUNUT1IgR09OWkFMRVogTElSQSIsDQogICAgInJ1dFRhbGxlciI6ICI3NjEwMTgyMC01IiwNCiAgICAibm9tYnJlVGFsbGVyIjogIkFVVE9NT1RSSVogVkFST05BIExUREEiLA0KICAgICJpbnZvbHVjcmFkbyI6ICIiLA0KICAgICJub21icmVUZXJjZXJvIjogIiIsDQogICAgInJ1dFRlcmNlcm8iOiAiIiwNCiAgICAicmVsYXRvIjogIkVsIGRpYSBWaWVybmVzIiwNCiAgICAiZmVjaGFFbnZpb090IjogIjE0LTEyLTIwMjAgIDIwOjExOjMwIiwNCiAgICAiZmVjaGFSZWNlcGNpb25WZWhpY3VsbyI6ICIzMS0xMi0yMDIwIiwNCiAgICAiZmVjaGFFbnZpb0luZm9ybWVMaXF1aWRhY2lvbiI6ICIiLA0KICAgICJkb2N1bWVudG9zUmVxdWVyaWRvcyI6ICIiLA0KICAgICJmZWNoYVJlY2VwY2lvbkRvY3VtZW50b3MiOiAiIiwNCiAgICAiZmVjaGFTb2xpY2l0dWREb2N1bWVudG9zIjogIiIsDQogICAgImZlY2hhUmVhc2lnbmFjaW9uVGFsbGVyIjogIiIsDQogICAgImZlY2hhUmVhc2lnbmFjaW9uTGlxdWlkYWRvciI6ICIiLA0KICAgICJmZWNoYUdlbmVyYWNpb25GaW5pcXVpdG8iOiAiIiwNCiAgICAiZmVjaGFFbnZpb0NhcnRhcyI6ICIiLA0KICAgICJmZWNoYUNhcnRhQXNpZ25hY2lvbiI6ICIiLA0KICAgICJmZWNoYUNhcnRhUmVhc2lnbmFjaW9uIjogIiIsDQogICAgImZlY2hhQ2FydGFEZWR1Y2libGVJbnRlbGlnZW50ZSI6ICIiLA0KICAgICJmZWNoYUNhcnRhT3JkZW5SZXBhcmFjaW9uIjogIiIsDQogICAgImZlY2hhQ2FydGFEZXNhcm1lIjogIiIsDQogICAgImZlY2hhQ2FydGFFcHQiOiAiIiwNCiAgICAiZmVjaGFSZWNoYXpvQmFqb0RlZHVjaWJsZSI6ICIiLA0KICAgICJmZWNoYUFzaWduYWNpb25UZXJjZXJvIjogIiIsDQogICAgImZlY2hhQXZpc29Bc2VndXJhZG9UZXJjZXJvT2siOiAiIiwNCiAgICAiZmVjaGFQYWdvRmluaXF1aXRvIjogIiIsDQogICAgImZlY2hhUHJvcnJvZ2EiOiAiIiwNCiAgICAiZmVjaGFFbnZpb1Ntc0FzaWduYWNpb24iOiAiIiwNCiAgICAiZmVjaGFTbXNSZWFzaWduYWNpb24iOiAiIiwNCiAgICAiZmVjaGFTbXNBdmlzb0luZ3Jlc29EZW51bmNpbyI6ICIiLA0KICAgICJmZWNoYVNtc0F2aXNvSW5ncmVzb1ZlaGljdWxvVGFsbGVyIjogIiIsDQogICAgImZlY2hhU21zRGVzYXJtZUFqdXN0ZSI6ICIiLA0KICAgICJmZWNoYVNtc0NvbmZpcm1hY2lvbkZlY2hhRW50cmVnYSI6ICIiLA0KICAgICJmZWNoYVNtc0V2YWx1YWNpb25QdCI6ICIiLA0KICAgICJmZWNoYVNtc09yIjogIiIsDQogICAgImZlY2hhU21zRmluaXF1aXRvU2luaWVzdHJvIjogIiIsDQogICAgImZlY2hhU21zQXNlZ3VyYWRvQXRlbmNpb25UZXJjZXJvIjogIiIsDQogICAgImZlY2hhU21zQXNlZ3VyYWRvRmluaXF1aXRvVGVyY2VybyI6ICIiLA0KICAgICJmZWNoYVNtc05vdGlmaWNhY2lvbkluZ3Jlc29UYWxsZXIiOiAiIiwNCiAgICAiZmVjaGFTbXNSZWNlcGNpb25WZWhpY3VsbyI6ICIiLA0KICAgICJmZWNoYVNtc1Byb2NlZGltaWVudG9BdGVuY2lvbiI6ICIiLA0KICAgICJmZWNoYUV2YWx1YWNpb24iOiAiIiwNCiAgICAidGlwb1BhZ28iOiAiIiwNCiAgICAiZmVjaGFQYWdhckluZGVtbml6YWNpb24iOiAiIiwNCiAgICAidGlwb0luZGVtbml6YWNpb24iOiAiIiwNCiAgICAicHJlbmRhIjogIiIsDQogICAgInBlcmRpZGFDb252ZW5pZGEiOiAiIiwNCiAgICAiZWplY3V0aXZvSW5kZW1uaXphY2lvbiI6ICIiLA0KICAgICJlamVjdXRpdm9Db21wcmFWZWhpY3VsbyI6ICIiLA0KICAgICJlamVjdXRpdm9QZXJkaWRhc1BhcmNpYWwiOiAiIiwNCiAgICAiZWplY3V0aXZvVXBwVXB0IjogIiIsDQogICAgImZlY2hhQW5hbGlzaXNJbmRlbW5pemFjaW9uUGVyZGlkYSI6ICIiLA0KICAgICJmZWNoYUdlbmVyYWNpb25PcmRlblBhZ28iOiAiIiwNCiAgICAiZmVjaGFBdXRvcml6YWNpb24iOiAiIiwNCiAgICAiZmVjaGFFbnZpb0VuY3Vlc3RhQ2xpZW50ZXNUYWxsZXIiOiAiIiwNCiAgICAiZmVjaGFFbnZpb0VuY3Vlc3RhSW5kZW1Db21wcmEiOiAiIg0KfQ0KDQo=';
        
        return b;
    }

}