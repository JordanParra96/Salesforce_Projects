/**
 * @description Test class for LoginEventSelector class.
 */
@IsTest
private class LoginEventSelectorTest {
  /**
   * @description Test method for LoginEventSelector class method selectByEventDate.
   */
  @IsTest
  static void selectByEventDate() {
    Test.startTest();
    List<LoginEvent> loginEvents = new LoginEventSelector()
      .selectByEventDate(Date.today(), 100);
    Test.stopTest();
    System.Assert.areEqual(0, loginEvents.size(), 'Expected 0 login events');
  }

  /**
   * @description Test method for LoginEventSelector class method selectAll.
   */
  @IsTest
  static void selectAll() {
    Test.startTest();
    List<LoginEvent> loginEvents = new LoginEventSelector().selectAll();
    Test.stopTest();
    System.Assert.areEqual(0, loginEvents.size(), 'Expected 0 login events');
  }

  /**
   * @description Test method for LoginEventSelector class method selectAll with limit.
   */
  @IsTest
  static void selectAllWithLimit() {
    Test.startTest();
    List<LoginEvent> loginEvents = new LoginEventSelector().selectAll(1);
    Test.stopTest();
    System.Assert.areEqual(0, loginEvents.size(), 'Expected 0 login events');
  }
}
