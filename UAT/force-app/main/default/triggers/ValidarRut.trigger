trigger ValidarRut on Case (before insert) {
    for (Case c : Trigger.new) {
        if (!String.isEmpty(c.HDI4I_Rut__c)) {
            Pattern p = Pattern.compile('^[a-zA-Z0-9]{7,8}-[0-9kK]$');
            Matcher m = p.matcher(c.HDI4I_Rut__c);
            if (!m.matches()) {
                c.addError('El campo HDI4I_Rut__c debe tener el formato correcto: 7-8 caracteres alfanuméricos seguidos de un guion y un dígito o K.');
            }
        }
    }
}