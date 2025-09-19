/**
 * @description A class that performs an external search using Google.
 */
public class ExternalSearch {
  /**
   * @description Exception class for handling errors in ExternalSearch.
   */
  public class ExternalSearchException extends Exception {
  }

  /**
   * @description Performs a Google search for the given query and returns the response body.
   * @param query - The search query.
   * @return String - The response body from the Google search.
   * @throws ExternalSearchException - If the HTTP response status code is not 200.
   */
  public static string googleIt(String query) {
    Http h = new Http();
    HttpRequest req = new HttpRequest();
    req.setEndpoint('https://www.google.com?q=' + query);
    req.setMethod('GET');
    HttpResponse res = h.send(req);
    if (res.getStatusCode() != 200) {
      throw new ExternalSearchException(
        'Did not receive a 200 status code: ' + res.getStatusCode()
      );
    }
    return res.getBody();
  }
}
