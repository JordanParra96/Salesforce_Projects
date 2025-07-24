/**
 * @description This class wraps an Account and provides methods to calculate
 * the rounded average price of Opportunities and check if the account is high priority.
 */
public with sharing class AccountWrapper {
  /**
   * @description This class is used to throw exceptions specific to AccountWrapper.
   */
  public class AWException extends exception {
  }

  Account thisAccount;

  /**
   * @description Constructor for AccountWrapper.
   * @param startWith The Account to wrap.
   */
  public AccountWrapper(Account startWith) {
    thisAccount = startWith;
  }

  /**
   * @description Gets the rounded average price of Opportunities for the wrapped Account.
   * @return The rounded average price of Opportunities.
   * @throws AWException if there are no won Opportunities.
   */
  public decimal getRoundedAvgPriceOfOpps() {
    AggregateResult[] ar = [
      SELECT AVG(Amount)
      FROM Opportunity
      WHERE accountId = :thisAccount.Id
      WITH USER_MODE
    ];

    Decimal average = (Decimal) ar[0].get('expr0');
    Long modulus = Math.mod(Integer.valueOf(average), 1000);
    Decimal returnValue = (modulus >= 500)
      ? (average + 1000) - modulus
      : average - modulus;
    if (returnValue <= 0) {
      throw new AWException('No won Opportunities');
    }
    return returnValue;
  }

  /**
   * @description Checks if the wrapped Account is high priority based on the average price of Opportunities.
   * @return True if the average price of Opportunities is greater than 100000.00, otherwise false.
   */
  public Boolean isHighPriority() {
    if (getRoundedAvgPriceOfOpps() > 100000.00) {
      return true;
    }
    return false;
  }
}
