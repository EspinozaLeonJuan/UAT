trigger ValidarContact on Contact (before insert) {
    for (Contact c : Trigger.new) {
        if (!String.isEmpty(c.Rut_sin_puntos_y_con_gui_n__c)) {
            Pattern p = Pattern.compile('^[a-zA-Z0-9]{7,8}-[0-9kK]$');
            Matcher m = p.matcher(c.Rut_sin_puntos_y_con_gui_n__c);
            if (!m.matches()) {
                c.addError('El campo HDI4I_Rut__c debe tener el formato correcto: 7-8 caracteres alfanuméricos seguidos de un guion y un dígito o K.');
            }
        }
    }
}