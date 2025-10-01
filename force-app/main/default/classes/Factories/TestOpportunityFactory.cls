/*
 * @description A factory class for creating test Opportunities.
 */
@isTest
public class TestOpportunityFactory {
  /**
   * @description Generates Opportunities for a specified Account.
   * @param accountId The Id of the Account to associate with the Opportunities.
   * @param amount The amount for each Opportunity.
   * @param numOpps The number of Opportunities to create.
   * @return A list of created Opportunities.
   */
  public static Opportunity[] generateOppsForAccount(
    id accountId,
    Decimal amount,
    Integer numOpps
  ) {
    List<Opportunity> opps = new List<Opportunity>();
    for (Integer i = 0; i < numOpps; i++) {
      Opportunity o = new Opportunity();
      o.name = 'Account ' + i;
      o.accountId = accountid;
      o.amount = amount;
      o.closeDate = Date.today().addDays(5);
      o.stageName = 'Prospecting';
      opps.add(o);
    }
    return opps;
  }

  /**
   * @description Generates Opportunity for a specified Account using parameters.
   * @param params A map containing parameters for the Opportunity:
   *               - account: The Account to associate with.
   *               - name: The name of the Opportunity.
   *               - closeDate: The close date of the Opportunity.
   *               - stageName: The stage name of the Opportunity.
   *               - doInsert: Whether to insert the Opportunity into the database.
   *               - uow: The unit of work to use for inserting the Opportunity.
   * @return An array of created Opportunity.
   */
  public static Opportunity getOpportunity(Map<String, Object> params) {
    TestFactory.clearData();
    Account acc = (Account) params.get('account');
    String name = (String) params.get('name');
    Date closeDate = (Date) params.get('closeDate');
    String stageName = (String) params.get('stageName');
    Boolean doInsert = (Boolean) params.get('doInsert');
    fflib_SObjectUnitOfWork uow = (fflib_SObjectUnitOfWork) params.get('uow');

    Opportunity opp = new Opportunity(
      name = name,
      closeDate = closeDate,
      stageName = stageName
    );
    if (doInsert) {
      uow.registerRelationship(opp, Opportunity.AccountId, acc);
      uow.registerNew(opp);
      uow.commitWork();
    }
    return opp;
  }
}
