public abstract class HDI_RestRoute {
    protected RestRequest request {
        get {
            return RestContext.request;
        }
        private set;
    }

    protected RestResponse response {
        get {
            return RestContext.response;
        }
        private set;
    }

    protected String[] relativePaths;
    public string resourceId;

    private static final String CUSTOM_REST_BASE = '/services/apexrest';

    public void loadResourceId() {
        if (this.relativePaths.size() >= 1) {
            this.resourceId = this.popNextPath();
        }
    }

    /**
     *  Runs the Route Tree and sets the RestResponse
     *    Should ONLY be called from the top level @RestResource HDI_RestRoute
     */
    public void execute() {
        try {
            this.parseRelativePath();
            response.addHeader('Content-Type', 'application/json');

            Object resp = this.route();
            if (resp != null) {
                //body may have already been set directly on response object
                response.responseBody = Blob.valueOf(JSON.serialize(resp));
            }
            if (response.statusCode == null) {
                response.statusCode = 200;
            }
        } catch (Exception e) {
            this.handleException(e);
        }
    }

    // === BEGIN TEMPLATE OVERRIDES ===

    /**
     *  Determines the next route to run.
     *    Only override when the base standard mapping is not robust enough
     *    If null is returned, will throw  `RouteNotFoundException`
     */
    protected virtual HDI_RestRoute next() {
        String nextPath = popNextPath();
        Map<String, HDI_RestRoute> routes = getNextRouteMap();
        if (routes != null && routes.containsKey(nextPath)) {
            HDI_RestRoute route = routes.get(nextPath);
            route.relativePaths = this.relativePaths;
            return routes.get(nextPath);
        }
        throw new RouteNotFoundException(request);
    }

    /**
     * Can be override to prevent popping the next URL part to the ResourceId
     */
    protected virtual boolean hasResource() {
        return true;
    }

    /**
     * Standard Route Mapping
     *  Key of String will be matched against the next URI path
     */
    protected virtual Map<String, HDI_RestRoute> getNextRouteMap() {
        return null;
    }

    /**
     * Handle Error
     *  Follows https://salesforce.stackexchange.com/questions/161429/rest-error-handling-design
     */
    protected virtual void handleException(Exception err) {
        if (err instanceof HDI_RestRouteError.RestException) {
            HDI_RestRouteError.RestException restErr = (HDI_RestRouteError.RestException) err;
            response.statusCode = restErr.statusCode;
            response.responseBody = Blob.valueOf(JSON.serialize(new List<HDI_RestRouteError.Response>{ restErr.errorResp }));
        } else {
            throw err; //let salesforce deal with it
        }
    }

    /**
     *  Determines the next route to run.
     *    Do not need to override if route is a leaf.
     *    If null is returned, will throw  `RouteNotFoundException`
     */
    protected virtual Object doGet() {
        throw new OperationNotSupportException(request);
    }
    protected virtual Object doPost() {
        throw new OperationNotSupportException(request);
    }
    protected virtual Object doDelete() {
        throw new OperationNotSupportException(request);
    }
    protected virtual Object doPut() {
        throw new OperationNotSupportException(request);
    }

    // === END TEMPLATE OVERRIDES ===

    //either responds to the request, or forwards it to the next HDI_RestRoute
    protected Object route() {
        System.debug(this.relativePaths);
        if (this.hasResource()) {
            this.loadResourceId();
        }

        if (!this.hasNextPath()) {
            return this.respond();
        }
        HDI_RestRoute nextRoute = this.next();
        if (nextRoute != null) {
            return nextRoute.route();
        }
        throw new HDI_RestRoute.RouteNotFoundException(request);
    }

    // run appropriate HTTP METHOD
    protected Object respond() {
        System.debug(request.httpMethod);
        switch on request.httpMethod {
            when 'GET' {
                return this.doGet();
            }
            when 'POST' {
                return this.doPost();
            }
            when 'DELETE' {
                return this.doDelete();
            }
            when 'PUT' {
                return this.doPut();
            }
            when else {
                throw new RouteNotFoundException(request);
            }
        }
    }

    /**
     *  returns true if there are more relative URI paths
     */
    protected Boolean hasNextPath() {
        return relativePaths.size() > 0;
    }

    /**
     *  pops the next relative Uri path
     */
    protected String popNextPath() {
        return relativePaths.remove(0);
    }

    protected String peakNextPath() {
        return relativePaths[0];
    }

    /**
     *  Runs all child routes and merges their results in the result object
     */
    protected Map<String, Object> expandResource(Object result) {
        Map<String, Object> expandedResult = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(result));
        Map<String, HDI_RestRoute> routes = getNextRouteMap();
        for (String key : routes.keySet()) {
            expandedResult.put(key, routes.get(key).respond());
        }
        return expandedResult;
    }

    // Sets up relativePaths on entry route
    // Only run on execute()
    private void parseRelativePath() {
        // init relative paths
        String basePath = this.request.resourcePath.replace(CUSTOM_REST_BASE, '').replace('/*', '');

        this.relativePaths = this.request.requestURI.replace(basePath, '').split('\\/');
        if (relativePaths.size() > 0 && String.isBlank(relativePaths.get(0))) {
            popNextPath();
        }
    }

    public class RouteNotFoundException extends HDI_RestRouteError.RestException {
        public RouteNotFoundException(RestRequest req) {
            super('Could not find route for: ' + req.requestURI, 'NOT_FOUND', 404);
        }
    }

    public class OperationNotSupportException extends HDI_RestRouteError.RestException {
        public OperationNotSupportException(RestRequest req) {
            super('Method is not supported ' + req.httpMethod, 'NOT_SUPPORTED', 400);
        }
    }

    public class EntityNotFoundException extends HDI_RestRouteError.RestException {
        public EntityNotFoundException(RestRequest req, String resourceId) {
            super('Entity does not exist: ' + resourceId, 'NOT_FOUND', 404);
        }
    }

    // useful for stubbing routing
    public class NotImplementedRoute extends HDI_RestRoute {
        public NotImplementedRoute() {
            super();
        }
    }
}