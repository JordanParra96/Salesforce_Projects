/**
 * @description Handles querying of ReportEvent records.
 */
public with sharing class EventQueryHandler {
  /**
   * @description Retrieves ReportEvent records that occurred today, limited to 100 records.
   * @return List<ReportEvent> - List of ReportEvent records from today.
   */
  public static List<ReportEvent> getReportEvents() {
    return new ReportEventSelector().selectByEventDate(Date.today(), 100);
  }
}
