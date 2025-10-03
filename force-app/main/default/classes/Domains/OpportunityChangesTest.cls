/*
 * @description Test class for OpportunityChanges trigger handler.
 */
@isTest
public class OpportunityChangesTest {
  /**
   * @description Test method for creating and updating an Opportunity record.
   */
  @isTest
  static void testCreateAndUpdateOpportunity() {
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
      new List<Schema.SObjectType>{ Opportunity.SObjectType }
    );
    Test.enableChangeDataCapture();

    List<Account> accounts = TestFactory.generateAccountsWithNames(
      new List<String>{
        'ACME',
        'Test Account',
        'Module Account',
        'Negative Account'
      },
      true
    );

    List<Opportunity> opps = TestFactory.generateOppsForAccount(
      accounts[0].id,
      1000.00,
      5
    );
    uow.registerNew(opps);
    uow.commitWork();

    Test.getEventBus().deliver();

    Opportunity[] oppRecords = new OpportunitiesSelector().selectAll();
    Opportunity opp = oppRecords[0];
    opp.StageName = 'Closed Won';
    update opp;

    Test.getEventBus().deliver();

    Task[] taskList = new TaskSelector().selectAll();
    System.assertEquals(
      1,
      taskList.size(),
      'The change event trigger did not create the expected task.'
    );
  }
}
