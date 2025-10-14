/**
 * @description Test class for ReportEventSelector
 */
@IsTest
private class ReportEventSelectorTest {
  /**
   * @description Test method for ReportEventSelector class method selectByEventDate.
   */
  @IsTest
  static void selectByEventDate() {
    Test.startTest();
    List<ReportEvent> reportEvents = new ReportEventSelector()
      .selectByEventDate(Date.today(), 100);
    Test.stopTest();
    System.Assert.areEqual(0, reportEvents.size(), 'Expected 0 report events');
  }

  /**
   * @description Test method for ReportEventSelector class method selectAll.
   */
  @IsTest
  static void selectAll() {
    Test.startTest();
    List<ReportEvent> reportEvents = new ReportEventSelector().selectAll();
    Test.stopTest();
    System.Assert.areEqual(0, reportEvents.size(), 'Expected 0 report events');
  }

  /**
   * @description Test method for ReportEventSelector class method selectAll with limit.
   */
  @IsTest
  static void selectAllWithLimit() {
    Test.startTest();
    List<ReportEvent> reportEvents = new ReportEventSelector().selectAll(1);
    Test.stopTest();
    System.Assert.areEqual(0, reportEvents.size(), 'Expected 0 report events');
  }
}
