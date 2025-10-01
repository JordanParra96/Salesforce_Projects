/**
 * @description Factory class for creating test Account records.
 */
@isTest
public class TestAccountFactory {
  /**
   * @description Creates an Account with the specified name.
   * @param name The name of the Account to create.
   * @param doInsert Whether to insert the Account into the database.
   * @param uow The unit of work to use for inserting the Account.
   * @return The created Account.
   */
  public static Account getAccount(
    String name,
    Boolean doInsert,
    fflib_SObjectUnitOfWork uow
  ) {
    Account a = new Account(name = name);
    if (doInsert) {
      uow.registerNew(a);
      uow.commitWork();
    }
    return a;
  }

  /**
   * @description Generates a specified number of Accounts.
   * @param numAccounts The number of Accounts to create.
   * @param doInsert Whether to insert the Accounts into the database.
   * @param uow The unit of work to use for inserting the Accounts.
   * @return An array of created Accounts.
   */
  public static Account[] generateAccounts(
    Integer numAccounts,
    Boolean doInsert,
    fflib_SObjectUnitOfWork uow
  ) {
    List<Account> accounts = new List<Account>();
    for (Integer i = 0; i < numAccounts; i++) {
      accounts.add(new Account(name = 'Test ' + i));
    }
    if (doInsert) {
      uow.registerNew(accounts);
      uow.commitWork();
    }
    return accounts;
  }

  /**
   * @description Generates Accounts with specified names.
   * @param names A list of names for the Accounts to create.
   * @param doInsert Whether to insert the Accounts into the database.
   * @param uow The unit of work to use for inserting the Accounts.
   * @return An array of created Accounts.
   */
  public static Account[] generateAccountsWithNames(
    List<String> names,
    Boolean doInsert,
    fflib_SObjectUnitOfWork uow
  ) {
    List<Account> accounts = new List<Account>();
    for (String name : names) {
      accounts.add(new Account(name = name));
    }
    if (doInsert) {
      uow.registerNew(accounts);
      uow.commitWork();
    }
    return accounts;
  }
}
