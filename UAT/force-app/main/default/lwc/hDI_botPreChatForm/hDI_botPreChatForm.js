import BasePrechat from 'lightningsnapin/basePrechat';
import { api, track } from 'lwc';
import startChatLabel from '@salesforce/label/c.StartChat';
import botPreChatFormCSS from "@salesforce/resourceUrl/HDI_PreChatFormCSS";
import { loadStyle } from "lightning/platformResourceLoader";

export default class HDI_botPreChatForm extends BasePrechat {
    @api prechatFields;
    @api selected
    @api bool=false
    @api errores;
    @track fields;
    @track namelist;
    startChatLabel;
 
    //Set the button label and prepare the prechat fields to be shown in the form.
    connectedCallback() {
        this.startChatLabel = startChatLabel;
        
        if (this.prechatFields) {
            this.fields = this.prechatFields.map(field => {
                field = JSON.parse(JSON.stringify(field));
                field.type = field.type.replace('input', '');
                console.log(field.name);
                const { label, name, value, required, maxLength, type } = field;
                return { label, name, value, required, maxLength, type };
            });
            this.namelist = this.fields.map(field => field.name);
        }
    }
    
    //set check


    //Focus on the first input after this component renders.
    renderedCallback() {
        Promise.all([
            loadStyle(this, botPreChatFormCSS),
        ]).then(() => { });
        if(!this.inputFocused) {
            let lightningInputElement = this.template.querySelector("lightning-input");
            let inputElement = this.template.querySelector('#input-9')
            console.log(inputElement);
            if (inputElement){
                inputElement.forEach(element => {
                    element.style.border = '2px solid green'
                    element.style.width = '80%';
                });
            }
            if (lightningInputElement) {
                lightningInputElement.focus();
                this.inputFocused = true;
            };
        }
    }
    
    // getter property to render the prechat fields
    get hasFields() {
        return this.fields && this.fields.length > 0;
    }
    //check
    check(inputElements){
        let temp = true
        let errors = []
        inputElements.forEach(element => {
           
            if (element.name === 'LastName' || element.name === 'FirstName') {
                let re = new RegExp("^(?=.{3,18}$)[A-Za-záéíóúñÁÉÍÓÚÑ ]+$");

                if (re.test(element.value)) {
                    console.log("Valid");
                } else {
                    console.log("Invalid");
                    if (errors.length === 0) {
                        errors.push('Nombre y/o Apellido')
                        // La cadena de texto NO contiene "Nombre y/o Apellido", no hacemos nada.
                    }
                      
                    temp = false
                }
            }
            if (element.name === 'Rut_sin_puntos_y_con_gui_n__c' && temp == true) {
                let re = new RegExp("^[a-zA-Z0-9]{7,8}-[0-9kK]$");
                if (re.test(element.value)) {
                    console.log("Valid");
                } else {
                    console.log("Invalid");
                    errors.push('Rut')
                    temp = false
                }
            }
            if (element.name === 'SuppliedEmail' && temp == true) {
                let re = new RegExp("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
                if (re.test(element.value)) {
                    console.log("Valid");
                } else {
                    console.log("Invalid");
                    errors.push('Email')
                    temp = false
                }
            }            
            if (element.name === 'SuppliedPhone' && temp == true) {
              let re = new RegExp(/^\d+$/);
               console.log(element.value);
               if (re.test(element.value)) {
                    console.log("Valid");
                } else {
                    console.log("Invalid");
                    errors.push('Telefono')
                    temp = false
                }
            }
            if (temp == true) {
                errors = [];
                this.bool = true
            } else { 
                console.log(errors);
                if (errors.length == 1) {
                    this.errores = 'El siguiente campo es incorrecto: '+ errors;
                } else {
                    this.errores = 'los siguientes campos son incorrectos: '+ errors;
                }

                this.bool = false
            }
        });
    }

    //On clicking the 'Start Chatting' button, send a chat request.
    handleStartChat(event) {
        event.preventDefault();
        let inputElements = this.template.querySelectorAll("lightning-input");
        this.check(inputElements)
        console.log(this.bool);
        if (inputElements && this.checkInputValidity(inputElements) && this.bool==true) {
            inputElements.forEach(input => {
                this.fields[this.namelist.indexOf(input.name)].value = input.value;
            });
            if (this.validateFields(this.fields).valid) {
                this.startChat(this.fields);
            } else {
                // Error handling if fields do not pass validation.
            }
        } else {

        }
    }


    //Toast

 
    checkInputValidity(inputElements) {
        const allValid = [...inputElements].reduce(
            (validSoFar, inputCmp) => {
                inputCmp.reportValidity();
                return validSoFar && inputCmp.checkValidity();
            }, true);
        return allValid;
    }

}