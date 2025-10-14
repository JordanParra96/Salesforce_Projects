/**
 * @description Selector class for ReportEvent object records.
 */
public with sharing class ReportEventSelector {
  /**
   * @description Selects ReportEvent records by their event dates.
   * @param eventDate - Date to select ReportEvent records by.
   * @param recordLimit - Maximum number of records to return.
   * @return List<ReportEvent> - List of ReportEvent records matching the provided event date.
   */
  public List<ReportEvent> selectByEventDate(
    Date eventDate,
    Integer recordLimit
  ) {
    return [
      SELECT
        ColumnHeaders,
        EventDate,
        ExportFileFormat,
        Format,
        NumberOfColumns,
        QueriedEntities,
        Records,
        ReportId,
        RowsProcessed,
        UserId,
        Username
      FROM ReportEvent
      WHERE EventDate = :eventDate
      WITH SECURITY_ENFORCED
      LIMIT :recordLimit
    ];
  }

  /**
   * @description Selects all ReportEvent records without any limit.
   * @return List<ReportEvent> - List of all ReportEvent records.
   */
  public List<ReportEvent> selectAll() {
    return this.selectAll(50000);
  }

  /**
   * @description Selects all ReportEvent records with a limit on the number of records returned.
   * @param recordLimit - Maximum number of records to return.
   * @return List<ReportEvent> - List of ReportEvent records.
   */
  public List<ReportEvent> selectAll(Integer recordLimit) {
    return [
      SELECT
        ColumnHeaders,
        EventDate,
        ExportFileFormat,
        Format,
        NumberOfColumns,
        QueriedEntities,
        Records,
        ReportId,
        RowsProcessed,
        UserId,
        Username
      FROM ReportEvent
      WITH SECURITY_ENFORCED
      LIMIT :recordLimit
    ];
  }
}
