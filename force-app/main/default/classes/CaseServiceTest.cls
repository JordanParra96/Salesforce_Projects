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
    Case testCase = TestFactory.generateCases(1, true)[0];

    Test.startTest();
    CaseService.closeCases(new Set<Id>{ testCase.Id }, 'Resolved');
    Test.stopTest();

    List<Case> testCases = new CasesSelector()
      .selectById(new Set<Id>{ testCase.Id });

    System.assertEquals(
      'Closed',
      testCases[0].Status,
      'Case status should be Closed'
    );
    System.assertEquals(
      'Resolved',
      testCases[0].Reason,
      'Case reason should be Resolved'
    );
  }
}
