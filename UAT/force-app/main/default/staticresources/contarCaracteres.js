    function contarcaracteres(can){
		
		var total=250;

		setTimeout(function(){
		
		var respuesta=document.getElementById('res');
		var cantidad=can.length;
		document.getElementById('res').innerHTML = cantidad + '/250';
		if(cantidad>total){
			respuesta.style.color = "red";
		}
		else {
			respuesta.style.color = "black";
		}
		},10);

	}

	function imprimir(campos, n){
        var j = campos[n];
        
        
        return j;
    }