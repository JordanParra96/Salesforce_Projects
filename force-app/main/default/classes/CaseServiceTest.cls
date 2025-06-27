/**
 * @description Service class for handling Case operations such as closing cases.
 */
@isTest
private class CaseServiceTest {
  /**
   * @description Tests the closeCases method of CaseService.
   * It creates a test case, calls the service to close it, and verifies the status and reason.
   */
  @IsTest
  static void testCloseCases() {
    Case testCase = new Case(Status = 'New');
    insert testCase;

    Test.startTest();
    CaseService.closeCases(new Set<Id>{ testCase.Id }, 'Resolved');
    Test.stopTest();

    testCase = [SELECT Status, Reason FROM Case WHERE Id = :testCase.Id];
    System.assertEquals(
      'Closed',
      testCase.Status,
      'Case status should be Closed'
    );
    System.assertEquals(
      'Resolved',
      testCase.Reason,
      'Case reason should be Resolved'
    );
  }
}
