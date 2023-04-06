import { LightningElement, track, api, wire } from 'lwc';
import getListArchivos from '@salesforce/apex/BECS_ListArchivosController.getListArchivos';

const columns = [
    { label: 'Titulo', fieldName: 'documentId', type: 'url', typeAttributes: { label: { fieldName: 'Title' }}, hideDefaultActions: true },
    { label: 'Creación', fieldName: 'CreatedDate', type: 'date',  hideDefaultActions: true},
    { label: 'Tipo', fieldName: 'FileExtension',  hideDefaultActions: true}
];

export default class ListArchivos extends LightningElement {
    @api recordId;
    columns = columns;
    @track listArchivos;

    @wire(getListArchivos, { recordId: '$recordId'})
    wiredGetCurrentValueData(value) {
        const { data, error } = value; 
        if(data) {
            //this.listArchivos = data;  

            let tempRecs = [];
            data.forEach( ( record ) => {
                let tempRec = Object.assign( {}, record );  
                tempRec.documentId = '/lightning/r/ContentDocument/' + tempRec.Id + '/view';
                tempRecs.push( tempRec );
                
            });
            this.listArchivos = tempRecs;

        }else{
            console.log(`Error: ${error}`);
        }
    }
}