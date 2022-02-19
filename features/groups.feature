Feature: groups page for upcoming games

  As a student
  So that I can join, create, and leave groups
  I want a webpage that will display info about my groups and allow me to edit it

  Background: groups in database

    Given the following groups exist:
      | groupname       | member          | pulled  |
      | Kareem's Group  | Kareem Hirani   | false   |
      | Baldwin's Group | Baldwin Bakkal  | false   |
      | Reid's Group    | Reid Neason     | false   |
      | Jon's Group     | Jon Waterman    | false   |

  @wip
  Scenario: return to home page

    Given I am on the groups page
    When I press "List Eater"
    Then I should be on the home page

  Scenario: view a group

    Given I am on the groups page
    When I press "View"
    Then I should see "Groupname:"
    And I should see "Member:"
    And I should see "Pulled:"

  Scenario: access edit group page

    Given I am on the groups page
    When I press "View"
    And I press "Edit this Game"
    Then I should see "Editing group"

  Scenario: group change reflected on info page

    Given I am on the groups page
    When I press "View"
    And I press "Edit this Game"
    And I enter the pulled status "true"
    And I press "Update Group"
    Then I should see "Pulled: true"

  Scenario: game change reflected on games page

    Given I am on the groups page
    When I press "View"
    And I press "Edit this Game"
    And I enter the groupname "Team Hirani"
    And I press "Update Group"
    And I press "Back to Groups"
    Then I should see "Team Hirani"

  Scenario: deleting a group

    Given I am on the groups page
    When I press "View"
    And I press "Destroy this Group"
    Then I should see "Group was successfully destroyed."

  Scenario: updating a group

    Given I am on the groups page
    When I press "View"
    And I press "Edit this Game"
    And I enter the group name "Team 2"
    And I press "Update Group"
    Then I should see "Groupname: Team 2"