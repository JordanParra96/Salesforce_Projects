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
    // Create a Unit Of Work
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
      new List<Schema.SObjectType>{ Case.SObjectType }
    );

    Case testCase = new Case(Status = 'New');
    uow.registerNew(testCase);
    uow.commitWork();

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
