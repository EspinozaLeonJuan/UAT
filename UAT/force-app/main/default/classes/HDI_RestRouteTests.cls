@isTest
public class HDI_RestRouteTests {
    private static final String RESOURCE_URL = '/api/*';
    private static final String RESOURCE_PATH = '/services/apexrest' + RESOURCE_URL;

    @isTest
    public static void testEntryRoute() {
        HDI_RestRouteTestUtil.setupRestContext(RESOURCE_PATH, '/api/v1');
        RestResponse resp = RestContext.Response;

        HDI_RestRouteTestRoutes.APIEntryRoute router = new HDI_RestRouteTestRoutes.APIEntryRoute();
        router.execute();

        System.assertEquals(400, resp.statusCode);
    }

    @isTest
    public static void testEntryRouteCollections() {
        HDI_RestRouteTestUtil.setupRestContext(RESOURCE_PATH, '/api');
        RestResponse resp = RestContext.Response;

        HDI_RestRouteTestRoutes.APIEntryRoute router = new HDI_RestRouteTestRoutes.APIEntryRoute();
        router.execute();

        System.assertEquals(400, resp.statusCode);
    }

    @isTest
    public static void testBaseRouteCollection() {
        HDI_RestRouteTestUtil.setupRestContext(RESOURCE_PATH, '/api/v1/companies/');
        RestResponse resp = RestContext.Response;

        HDI_RestRouteTestRoutes.APIEntryRoute router = new HDI_RestRouteTestRoutes.APIEntryRoute();
        router.execute();

        System.assertEquals(200, resp.statusCode);
        HDI_RestRouteTestRoutes.Company[] respData = (HDI_RestRouteTestRoutes.Company[]) JSON.deserialize(
            resp.responseBody.toString(),
            List<HDI_RestRouteTestRoutes.Company>.class
        );

        System.assertEquals(2, respData.size());
    }

    @isTest
    public static void testNoResourceRoute() {
        HDI_RestRouteTestUtil.setupRestContext(RESOURCE_PATH, '/api/v1/other/foo');
        RestResponse resp = RestContext.Response;

        HDI_RestRouteTestRoutes.APIEntryRoute router = new HDI_RestRouteTestRoutes.APIEntryRoute();
        router.execute();

        System.assertEquals(200, resp.statusCode);

        System.assertEquals('foo', resp.responseBody.toString());
    }

    @isTest
    public static void testBaseRouteCollection2() {
        HDI_RestRouteTestUtil.setupRestContext(RESOURCE_PATH, '/api/v1/companies');
        RestResponse resp = RestContext.Response;

        HDI_RestRouteTestRoutes.APIEntryRoute router = new HDI_RestRouteTestRoutes.APIEntryRoute();
        router.execute();

        System.assertEquals(200, resp.statusCode);
        HDI_RestRouteTestRoutes.Company[] respData = (HDI_RestRouteTestRoutes.Company[]) JSON.deserialize(
            resp.responseBody.toString(),
            List<HDI_RestRouteTestRoutes.Company>.class
        );

        System.assertEquals(2, respData.size());
    }

    @isTest
    public static void testBaseRouteSingle() {
        HDI_RestRouteTestUtil.setupRestContext(RESOURCE_PATH, '/api/v1/companies/c-1');
        RestResponse resp = RestContext.Response;

        HDI_RestRouteTestRoutes.APIEntryRoute router = new HDI_RestRouteTestRoutes.APIEntryRoute();
        router.execute();

        System.assertEquals(200, resp.statusCode);
        HDI_RestRouteTestRoutes.Company respData = (HDI_RestRouteTestRoutes.Company) JSON.deserialize(
            resp.responseBody.toString(),
            HDI_RestRouteTestRoutes.Company.class
        );

        System.assertEquals('c-1', respData.id);
    }

    @isTest
    public static void testSingleExpanded() {
        HDI_RestRouteTestUtil.setupRestContext(RESOURCE_PATH, '/api/v1/companies/c-1', new Map<String, String>{ 'expand' => '1' });
        RestResponse resp = RestContext.Response;

        HDI_RestRouteTestRoutes.APIEntryRoute router = new HDI_RestRouteTestRoutes.APIEntryRoute();
        router.execute();

        System.assertEquals(200, resp.statusCode);

        // TODO make useful assertions
        // System.assertEquals('', resp.responseBody.toString());
    }

    @isTest
    public static void testCollectionExpanded() {
        HDI_RestRouteTestUtil.setupRestContext(RESOURCE_PATH, '/api/v1/companies', new Map<String, String>{ 'expand' => '1' });
        RestResponse resp = RestContext.Response;

        HDI_RestRouteTestRoutes.APIEntryRoute router = new HDI_RestRouteTestRoutes.APIEntryRoute();
        router.execute();

        System.assertEquals(200, resp.statusCode);

        // TODO make useful assertions
        // System.assertEquals('', resp.responseBody.toString());
    }

    @isTest
    public static void testNestedRouteCollection() {
        HDI_RestRouteTestUtil.setupRestContext(RESOURCE_PATH, '/api/v1/companies/c-2/locations');
        RestResponse resp = RestContext.Response;

        HDI_RestRouteTestRoutes.APIEntryRoute router = new HDI_RestRouteTestRoutes.APIEntryRoute();
        router.execute();

        System.assertEquals(200, resp.statusCode);
        HDI_RestRouteTestRoutes.CompanyLocation[] respData = (HDI_RestRouteTestRoutes.CompanyLocation[]) JSON.deserialize(
            resp.responseBody.toString(),
            List<HDI_RestRouteTestRoutes.CompanyLocation>.class
        );

        System.assertEquals(1, respData.size());
        System.assertEquals('LA', respData[0].name);
    }

    @isTest
    public static void testAlternateRoute() {
        HDI_RestRouteTestUtil.setupRestContext(RESOURCE_PATH, '/api/v1/employees', new Map<String, String>{ 'companyId' => 'c-2' });
        RestResponse resp = RestContext.Response;

        HDI_RestRouteTestRoutes.APIEntryRoute router = new HDI_RestRouteTestRoutes.APIEntryRoute();
        router.execute();

        System.assertEquals(200, resp.statusCode);
        HDI_RestRouteTestRoutes.CompanyEmployee[] respData = (HDI_RestRouteTestRoutes.CompanyEmployee[]) JSON.deserialize(
            resp.responseBody.toString(),
            List<HDI_RestRouteTestRoutes.CompanyEmployee>.class
        );

        System.assertEquals(3, respData.size());
        System.assertEquals('Iron Man', respData[0].name);
    }

    @isTest
    public static void testRouteCollectionFilter() {
        HDI_RestRouteTestUtil.setupRestContext(RESOURCE_PATH, '/api/v1/companies/c-2/employees', new Map<String, String>{ 'role' => 'CEO' });
        RestResponse resp = RestContext.Response;

        HDI_RestRouteTestRoutes.APIEntryRoute router = new HDI_RestRouteTestRoutes.APIEntryRoute();
        router.execute();

        System.assertEquals(200, resp.statusCode);
        HDI_RestRouteTestRoutes.CompanyEmployee[] respData = (HDI_RestRouteTestRoutes.CompanyEmployee[]) JSON.deserialize(
            resp.responseBody.toString(),
            List<HDI_RestRouteTestRoutes.CompanyEmployee>.class
        );

        System.assertEquals(2, respData.size());
        System.assertEquals('Iron Man', respData[0].name);
    }

    @isTest
    public static void testNestedRouteSingle() {
        HDI_RestRouteTestUtil.setupRestContext(RESOURCE_PATH, '/api/v1/companies/c-1/employees/e-2');
        RestResponse resp = RestContext.Response;

        HDI_RestRouteTestRoutes.APIEntryRoute router = new HDI_RestRouteTestRoutes.APIEntryRoute();
        router.execute();

        System.assertEquals(200, resp.statusCode);
        HDI_RestRouteTestRoutes.CompanyEmployee respData = (HDI_RestRouteTestRoutes.CompanyEmployee) JSON.deserialize(
            resp.responseBody.toString(),
            HDI_RestRouteTestRoutes.CompanyEmployee.class
        );

        System.assertEquals('e-2', respData.id);
    }

    @isTest
    public static void testNestedRouteSingleNotRelated() {
        HDI_RestRouteTestUtil.setupRestContext(RESOURCE_PATH, '/api/v1/companies/c-2/employees/e-2');
        RestResponse resp = RestContext.Response;

        HDI_RestRouteTestRoutes.APIEntryRoute router = new HDI_RestRouteTestRoutes.APIEntryRoute();
        router.execute();

        System.assertEquals(404, resp.statusCode);
        HDI_RestRouteError.Response[] respData = HDI_RestRouteTestUtil.parseResponseErrors(resp);

        System.assertEquals(1, respData.size());
        System.assertEquals('NOT_FOUND', respData[0].errorCode);
    }

    @isTest
    public static void testNoRouteFound() {
        HDI_RestRouteTestUtil.setupRestContext(RESOURCE_PATH, '/api/v1/companies/c-2/asdf');
        RestResponse resp = RestContext.Response;

        HDI_RestRouteTestRoutes.APIEntryRoute router = new HDI_RestRouteTestRoutes.APIEntryRoute();
        router.execute();

        System.assertEquals(404, resp.statusCode);
        HDI_RestRouteError.Response[] respData = HDI_RestRouteTestUtil.parseResponseErrors(resp);

        System.assertEquals(1, respData.size());
        System.assertEquals('NOT_FOUND', respData[0].errorCode);
    }
}