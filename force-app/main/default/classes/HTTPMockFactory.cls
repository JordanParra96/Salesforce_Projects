/**
 * @description A generic HTTP mock class that can be used to mock HTTP callouts in tests.
 */
@IsTest
public class HTTPMockFactory implements HttpCalloutMock {
  protected Integer code;
  protected String status;
  protected String body;
  protected Map<String, String> responseHeaders;

  /**
   * @description Constructor for HTTPMockFactory.
   * @param code - The HTTP status code to return.
   * @param status - The HTTP status message to return.
   * @param body - The HTTP response body to return.
   * @param responseHeaders - The HTTP response headers to return.
   */
  public HTTPMockFactory(
    Integer code,
    String status,
    String body,
    Map<String, String> responseHeaders
  ) {
    this.code = code;
    this.status = status;
    this.body = body;
    this.responseHeaders = responseHeaders;
  }

  /**
   * @description Responds to the HTTP request with the configured response.
   * @param req - The HTTP request to respond to.
   * @return HTTPResponse - The HTTP response.
   */
  public HTTPResponse respond(HTTPRequest req) {
    HttpResponse res = new HttpResponse();
    for (String key : this.responseHeaders.keySet()) {
      res.setHeader(key, this.responseHeaders.get(key));
    }
    res.setBody(this.body);
    res.setStatusCode(this.code);
    res.setStatus(this.status);
    return res;
  }
}
