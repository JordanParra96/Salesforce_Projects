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
    HTTPMockFactory mock = new HTTPMockFactory(
      200,
      'OK',
      'I found it!',
      new Map<String, String>()
    );
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
    HTTPMockFactory mock = new HTTPMockFactory(
      500,
      'Internal Server Error',
      'Something went wrong',
      new Map<String, String>()
    );
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
