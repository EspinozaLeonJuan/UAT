public with sharing class HDI_RestRouteError {

    public class Response {
        public String errorCode;
        public String message;
        public HDI_ApiResponseWrapper responseBody;
        public Response(String errorCode, String message) {
            this.errorCode = errorCode;
            this.message = message;
        }
        public Response(String errorCode, string message, HDI_ApiResponseWrapper responseBody) {
            this.errorCode = errorCode;
            this.message = message;
            this.responseBody = responseBody;
        }
    }
    public virtual class RestException extends Exception {
        public Response errorResp;
        public Integer statusCode;
        public RestException(
            String message,
            String errorCode,
            Integer statusCode
        ) {
            this.setMessage(message);
            this.errorResp = new Response(errorCode, message);
            this.statusCode = statusCode;
        }

        public RestException(String message, String errorCode, Integer statusCode, HDI_ApiResponseWrapper responseBody) {
            this.setMessage(message);
            this.errorResp = new Response(errorCode, message, responseBody);
            this.statusCode = statusCode;
        }
    }
}