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
   * @description Constructor for HTTPMockFactory using parameter object.
   * @param params - The parameter object containing HTTP response details.
   */
  public HTTPMockFactory(HTTPMockParams params) {
    this.code = params.code;
    this.status = params.status;
    this.body = params.body;
    this.responseHeaders = params.responseHeaders;
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

  /**
   * @description Parameter object for HTTPMockFactory constructor.
   */
  public class HTTPMockParams {
    public Integer code;
    public String status;
    public String body;
    public Map<String, String> responseHeaders;
  }
}
