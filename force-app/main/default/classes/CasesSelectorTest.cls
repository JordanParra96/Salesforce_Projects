/**
 * @description Test class for the CasesSelector class.
 */
@isTest
private class CasesSelectorTest {
  /**
   * @description Test method for AccountSelector class.
   */
  @isTest
  static void selectById() {
    // Create a Unit Of Work
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
      new List<Schema.SObjectType>{ Case.SObjectType }
    );

    List<Case> lstCases = new List<Case>{
      new Case(Status = 'New'),
      new Case(Status = 'New'),
      new Case(Status = 'New')
    };
    for (Case caseTest : lstCases) {
      uow.registerNew(caseTest);
    }

    uow.commitWork();

    List<Case> cases = new CasesSelector()
      .selectById(
        new Set<Id>{ lstCases[0].Id, lstCases[1].Id, lstCases[2].Id }
      );
    System.assertEquals(3, cases.size(), 'Should select 3 cases by ID');
  }
}
