/**
 * @description This class calculates the discount percentage for an opportunity based on the account's priority status.
 */
public class OpportunityDiscount {
  AccountWrapper acct;

  /**
   * @description Constructor that initializes the OpportunityDiscount with an AccountWrapper instance.
   * @param acct The AccountWrapper instance containing account details.
   */
  public OpportunityDiscount(AccountWrapper acct) {
    this.acct = acct;
  }

  /**
   * @description Method to get the total discount percentage based on account priority.
   * @return Decimal The discount percentage (0.25 for high priority accounts, 0.1 otherwise).
   */
  public Decimal getTotalDiscount() {
    if (this.acct.isHighPriority()) {
      return .25;
    } else {
      return .1;
    }
  }
}
