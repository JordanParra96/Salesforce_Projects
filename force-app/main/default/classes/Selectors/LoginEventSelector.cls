/**
 * @description Selector class for LoginEvent object records.
 */
public with sharing class LoginEventSelector {
  /**
   * @description Selects LoginEvent records by their event dates.
   * @param eventDate - Date to select LoginEvent records by.
   * @param recordLimit - Maximum number of records to return.
   * @return List<LoginEvent> - List of LoginEvent records matching the provided event date.
   */
  public List<LoginEvent> selectByEventDate(
    Date eventDate,
    Integer recordLimit
  ) {
    return [
      SELECT City, Country, SourceIp, Username
      FROM LoginEvent
      WHERE EventDate = TODAY
      WITH SECURITY_ENFORCED
      LIMIT :recordLimit
    ];
  }

  /**
   * @description Selects all LoginEvent records without any limit.
   * @return List<LoginEvent> - List of all LoginEvent records.
   */
  public List<LoginEvent> selectAll() {
    return this.selectAll(50000);
  }

  /**
   * @description Selects all LoginEvent records with a limit on the number of records returned.
   * @param recordLimit - Maximum number of records to return.
   * @return List<LoginEvent> - List of LoginEvent records.
   */
  public List<LoginEvent> selectAll(Integer recordLimit) {
    return [
      SELECT City, Country, SourceIp, Username
      FROM LoginEvent
      WITH SECURITY_ENFORCED
      LIMIT :recordLimit
    ];
  }
}
