/**
 * @description This class handles the retrieval of login events for monitoring purposes.
 */
public with sharing class LoginEventMonitoringHandler {
  /**
   * @description Retrieves LoginEvent records that occurred today, limited to 100 records.
   * @return List<LoginEvent> - List of LoginEvent records from today.
   */
  public static List<LoginEvent> getLoginEvents() {
    return new LoginEventSelector().selectByEventDate(Date.today(), 100);
  }
}
