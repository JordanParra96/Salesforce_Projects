/**
 * @description This is a test class for OpportunityDiscount.
 */
@IsTest
private class OpportunityDiscountTests {
  /**
   * @description Mock class for AccountWrapper to simulate different priority statuses.
   */
  @IsTest
  static void testPositiveStubbingLowPriority() {
    // GIVEN
    AccountWrapper mockAccountWrapper = (AccountWrapper) Test.createStub(
      AccountWrapper.class,
      new AccountWrapperMock()
    );
    OpportunityDiscount od = new OpportunityDiscount(mockAccountWrapper);
    // WHEN
    Test.startTest();
    Decimal result = od.getTotalDiscount();
    Test.stopTest();
    // THEN
    Assert.areEqual(.1, result, 'Expected to get .1');
  }

  /**
   * @description Mock implementation of AccountWrapper for testing purposes.
   */
  @IsTest
  static void testPositiveStubbingHighPriority() {
    // GIVEN
    AccountWrapperMock.isHighPriorityReturn = true;
    AccountWrapper mockAccountWrapper = (AccountWrapper) Test.createStub(
      AccountWrapper.class,
      new AccountWrapperMock()
    );
    OpportunityDiscount od = new OpportunityDiscount(mockAccountWrapper);
    // WHEN
    Test.startTest();
    Decimal result = od.getTotalDiscount();
    Test.stopTest();
    // THEN
    Assert.areEqual(.25, result, 'Expected to get .25');
  }
}
