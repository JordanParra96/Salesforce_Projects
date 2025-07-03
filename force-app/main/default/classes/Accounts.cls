/**
 * @description Domain class for Account objects.
 */
public with sharing class Accounts extends fflib_SObjectDomain {
  /**
   * @description Constructor for Accounts domain class.
   * @param sOjectList List of Account SObjects.
   */
  public Accounts(list<Account> sOjectList) {
    super(sOjectList);
  }

  /**
   * @description Factory method to create an instance of Accounts.
   * @param sObjectList List of Account SObjects.
   * @return An instance of Accounts domain class.
   */
  public class Constructor implements fflib_SObjectDomain.IConstructable {
    /**
     * @description Constructs an instance of Accounts domain class.
     * @param sObjectList List of Account SObjects.
     * @return An instance of Accounts domain class.
     */
    public fflib_SObjectDomain construct(List<SObject> sObjectList) {
      return new Accounts(sObjectList);
    }
  }

  /**
   * @description Factory method to create an instance of Accounts.
   */
  public override void onApplyDefaults() {
    for (Account account : (List<Account>) Records) {
      account.Description = 'Domain classes rock!';
    }
  }

  /**
   * @description Factory method to update the AnnualRevenue field based on the Description field.
   * @param existingRecords Map of existing records before update.
   */
  public override void onBeforeUpdate(Map<Id, SObject> existingRecords) {
    for (Account account : (List<Account>) Records) {
      account.AnnualRevenue = (account.Description)
        .getLevenshteinDistance('Domain classes rock!');
    }
  }
}
