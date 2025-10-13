public with sharing class LoginEventMonitoringHandler {
  public static List<LoginEvent> getLoginEvents() {
    return [
      SELECT City, Country, SourceIp, Username
      FROM LoginEvent
      WHERE EventDate = TODAY
    ];
  }
}
