/**
 * @description Test class for the OpportunitiesSelector class.
 */
@isTest
private class OpportunitiesSelectorTest {
  /**
   * @description Setup method to create test data.
   */
  @TestSetup
  static void makeData() {
    // Create a Unit Of Work
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
      new List<Schema.SObjectType>{ Opportunity.SObjectType }
    );

    Account a = TestFactory.getAccount('Test Account', true);

    Opportunity[] opps = TestFactory.generateOppsForAccount(a.Id, 1000, 5);
    uow.registerNew(opps);
    uow.commitWork();
  }

  /**
   * @description Test method for OpportunitiesSelector class.
   */
  @isTest
  static void selectById() {
    List<Opportunity> oppList = new OpportunitiesSelector().selectAll(5);
    list<Opportunity> opps = new OpportunitiesSelector()
      .selectById(
        new Set<Id>{
          oppList[0].Id,
          oppList[1].Id,
          oppList[2].Id,
          oppList[3].Id,
          oppList[4].Id
        }
      );

    System.assertEquals(5, opps.size(), 'Should select 5 opportunities by ID');
  }

  /**
   * @description Test method for selecting Opportunities by name.
   */
  @isTest
  static void selectByName() {
    Set<String> nameSet = new Set<String>{ 'Account 0', 'Account 1' };
    List<Opportunity> opps = new OpportunitiesSelector()
      .selectByName(nameSet, 10);

    System.assertEquals(
      2,
      opps.size(),
      'Should select 2 opportunities by name'
    );
  }

  /**
   * @description Test method for selecting all Opportunities.
   */
  @isTest
  static void selectAll() {
    List<Opportunity> opps = new OpportunitiesSelector().selectAll();

    System.assert(
      opps.size() >= 5,
      'Should select at least 5 opportunities in total'
    );
  }

  /**
   * @description Test method for selecting all Opportunities with a limit.
   */
  @isTest
  static void selectAllWithLimit() {
    list<Opportunity> opps = new OpportunitiesSelector().selectAll(2);
    System.assertEquals(
      2,
      opps.size(),
      'Should select 2 opportunities with limit'
    );
  }

  /**
   * @description Test method for selecting Opportunities by Account ID.
   */
  @isTest
  static void selectByAccountId() {
    List<Account> accList = new AccountsSelector().selectAll(1);
    Set<Id> accountIds = new Set<Id>{ accList[0].Id };
    List<Opportunity> opps = new OpportunitiesSelector()
      .selectByAccountId(accountIds);

    System.assert(
      opps.size() >= 5,
      'Should select at least 5 opportunities for the given account ID'
    );
  }
}
