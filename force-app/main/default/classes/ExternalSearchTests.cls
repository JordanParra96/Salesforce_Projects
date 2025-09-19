/**
 * @description Test class for ExternalSearch
 */
@IsTest
private class ExternalSearchTests {
  /**
   * @description Test method to verify that a callout is made to the google search API
   */
  @IsTest
  static void testPositiveMocking() {
    // GIVEN
    HTTPMockFactory.HTTPMockParams params = new HTTPMockFactory.HTTPMockParams();
    params.code = 200;
    params.status = 'OK';
    params.body = 'I found it!';
    params.responseHeaders = new Map<String, String>();
    HTTPMockFactory mock = new HTTPMockFactory(params);
    Test.setMock(HttpCalloutMock.class, mock);
    // WHEN
    Test.startTest();
    String result = ExternalSearch.googleIt('epic search');
    Test.stopTest();
    // THEN
    Assert.areEqual('I found it!', result, 'Expected to receive mock response');
  }

  /**
   * @description Test method to verify that an exception is thrown when the HTTP response status code is not 200
   */
  @IsTest
  static void testNegativeMocking() {
    // GIVEN
    HTTPMockFactory.HTTPMockParams params = new HTTPMockFactory.HTTPMockParams();
    params.code = 500;
    params.status = 'Internal Server Error';
    params.body = 'Something went wrong';
    params.responseHeaders = new Map<String, String>();
    HTTPMockFactory mock = new HTTPMockFactory(params);
    Test.setMock(HttpCalloutMock.class, mock);
    // WHEN
    Test.startTest();
    try {
      ExternalSearch.googleIt('epic search');
      Assert.fail('Expected an ExternalSearchException to be thrown');
    } catch (ExternalSearch.ExternalSearchException e) {
      // THEN
      Assert.areEqual(
        'Did not receive a 200 status code: 500',
        e.getMessage(),
        'Expected exception message to match'
      );
      Test.stopTest();
    }
  }
}
