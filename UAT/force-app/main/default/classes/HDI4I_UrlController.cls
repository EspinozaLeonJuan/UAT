public with sharing class HDI4I_UrlController {
	public class Url {
		public String UrlSimulador;
		public Transaccion transaccion;
	}

	public class Transaccion {
		public Integer estadoTrx;
		public Integer codigoError;
		public String glosaError;
	}

	
	public static HDI4I_UrlController parse(String json) {
		return (HDI4I_UrlController) System.JSON.deserialize(json, HDI4I_UrlController.class);
	}
}