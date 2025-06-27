/**
 * @description Resource class for handling Case closure operations.
 */
@isTest
private class CaseCloseResourceTest {
  /**
   * @description Tests the closeCase method of CaseCloseResource.
   * It creates a test case, calls the resource to close it, and verifies the case is closed.
   */
  @IsTest
  static void testCloseCase() {
    // Create a case
    Case c = new Case();
    insert c;
    // Create a rest context
    RestRequest req = new RestRequest();
    RestContext.request = req;
    req.requestURI = '/case/' + c.Id + '/close';
    // Call the service
    CaseCloseResource.closeCase('Resolved');
    // Verify the case is closed
    c = [SELECT Id, IsClosed FROM Case WHERE Id = :c.Id];
    System.assert(c.IsClosed);
  }
}
