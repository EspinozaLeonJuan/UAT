public class hdi {

	public class Url {
		public String UrlSimulador;
		public Transaccion transaccion;
	}

	public class Transaccion {
		public Integer estadoTrx;
		public Integer codigoError;
		public String glosaError;
	}

	
	public static Hdi parse(String json) {
		return (Hdi) System.JSON.deserialize(json, Hdi.class);
	}
}