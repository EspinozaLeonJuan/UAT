import { LightningElement } from 'lwc';
import { track } from 'lwc';

export default class botPreChatForm extends LightningElement {
    @track nombre = '';
    @track email = '';
    @track telefono = '';

    handleChange(event) {
        const fieldName = event.target.name;
        const fieldValue = event.target.value;
        this[fieldName] = fieldValue;
    }

    handleSubmit(event) {
        event.preventDefault();
        const allValid = [...this.template.querySelectorAll('lightning-input')]
            .reduce((validSoFar, inputCmp) => {
                inputCmp.reportValidity();
                return validSoFar && inputCmp.checkValidity();
            }, true);
        if (allValid) {
            // Ejecutar código para enviar el formulario
            console.log('Formulario válido, se puede enviar.');
        }
    }
}