/**
 * @description This class is used to select TopicAssignment records from the database.
 */
public with sharing class TopicAssignmentsSelector extends fflib_SObjectSelector {
  /**
   * @description Constructor for TopicAssignmentsSelector.
   * @return list<Schema.SObjectField> - List of SObject fields to be selected.
   */
  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      TopicAssignment.EntityId,
      TopicAssignment.TopicId
    };
  }

  /**
   * @description Returns the SObject type for the selector.
   * @return Schema.SObjectType - The SObject type for TopicAssignment.
   */
  public Schema.SObjectType getSObjectType() {
    return TopicAssignment.sObjectType;
  }

  /**
   * @description Selects TopicAssignment records by their IDs.
   * @param idSet - Set of IDs to select TopicAssignment by.
   * @return List<TopicAssignment> - List of TopicAssignment records matching the provided IDs.
   */
  public List<TopicAssignment> selectById(Set<ID> idSet) {
    return (List<TopicAssignment>) selectSObjectsById(idSet);
  }

  /**
   * @description Selects all TopicAssignment records.
   * @param recordLimit - Maximum number of records to return.
   * @return List<TopicAssignment> - List of FeedItem records.
   */
  public List<TopicAssignment> selectAll(Integer recordLimit) {
    return (List<TopicAssignment>) Database.query(
      newQueryFactory().setLimit(recordLimit).toSOQL()
    );
  }

  /**
   * @description Selects TopicAssignment records by their Topic.Name.
   * @param topicAssignments - List of TopicAssignment records to filter.
   * @param topicName - Name of the topic to filter by.
   * @param recordLimit - Maximum number of records to return.
   * @return List<TopicAssignment> - List of TopicAssignment records matching the provided lastnames.
   */
  public List<TopicAssignment> selectByTopicName(
    List<TopicAssignment> topicAssignments,
    String topicName,
    Integer recordLimit
  ) {
    return (List<TopicAssignment>) Database.query(
      newQueryFactory()
        .selectField('Topic.Name')
        .setCondition(
          'Id IN :topicAssignments AND Topic.Name LIKE \'%' + topicName + '%\''
        )
        .setLimit(recordLimit)
        .toSOQL()
    );
  }
}
