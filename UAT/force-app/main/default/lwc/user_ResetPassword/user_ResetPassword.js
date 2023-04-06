import { LightningElement, api } from 'lwc';
import resetPassword from '@salesforce/apex/Utilidades.resetUserPassword';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class User_ResetPassword extends LightningElement {
    @api recordId;

    setPassword() {
        resetPassword({ userId: this.recordId})
        .then(result => {
            this.pushMessage("Success!", "success", "A new password for the following user has been sent via email. The user will be required to enter a new password upon initial login to salesforce.com.");
        })
        .catch(error => {
            this.pushMessage("Error", "error", error.message);
        });
    }

    pushMessage(title,variant,msj){
        const message = new ShowToastEvent({
            "title": title,
            "variant": variant,
            "message": msj
            });
        this.dispatchEvent(message);
    }

}