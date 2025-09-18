/**
 * @description Test class for ProfileSelector
 */
@IsTest
private class ProfileSelectorTest {
  /**
   * @description Test method for ProfileSelector class.
   */
  @IsTest
  static void selectById() {
    List<Profile> profileList = new ProfileSelector().selectAll(2);

    System.assert(
      profileList.size() >= 2,
      'At least two profiles should exist'
    );

    List<Profile> profiles = new ProfileSelector()
      .selectById(new Set<Id>{ profileList[0].Id, profileList[1].Id });

    System.assertEquals(2, profiles.size(), 'Should select 2 profiles by ID');
  }

  /**
   * @description Test method for selecting Profiles by name.
   */
  @IsTest
  static void selectByName() {
    List<Profile> profiles = new ProfileSelector()
      .selectByName(new Set<String>{ 'Standard User' }, 1);

    System.assertEquals(1, profiles.size(), 'Should select 1 profiles by name');
  }

  /**
   * @description Test method for selecting all Profiles.
   */
  @IsTest
  static void selectAll() {
    List<Profile> profiles = new ProfileSelector().selectAll();

    System.assert(profiles.size() > 0, 'Should select at least 1 profile');
  }

  /**
   * @description Test method for selecting all Profiles with a limit.
   */
  @IsTest
  static void selectAllWithLimit() {
    List<Profile> profiles = new ProfileSelector().selectAll(2);

    System.assert(profiles.size() <= 2, 'Should select at most 2 profiles');
  }
}
