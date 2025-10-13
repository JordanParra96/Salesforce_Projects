public with sharing class EventQueryHandler {
  public static List<ReportEvent> getReportEvents() {
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
      WHERE EventDate = Today
    ];
  }
}
