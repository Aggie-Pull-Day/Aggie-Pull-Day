Feature: groups page for upcoming games

  As a student
  So that I can join, create, and leave groups
  I want a webpage that will display info about my groups and allow me to edit it

  Background: groups in database

    Given the database is populated
    And I am signed in as drritchey@tamu.edu

  @wip
  Scenario: return to home page

    Given I am on the groups page
    When I press "List Eaters"
    Then I should be on the home page

  Scenario: view a group

    Given I am on the groups page
    When I press "View"
    Then I should see "Group Name:"
    And I should see "Has not pulled"

  Scenario: access edit group page

    Given I am on the groups page
    When I press "View"
    And I press "Edit this Group"
    Then I should see "Editing Group"

  Scenario: group change reflected on info page

    Given I am on the groups page
    When I press "View"
    And I press "Edit this Group"
    And I check the box
    And I press "Update Group"
    Then I should see "Has pulled"

  Scenario: group change reflected on groups page

    Given I am on the groups page
    When I press "View"
    And I press "Edit this Group"
    And I enter the group groupname "Team Hirani"
    And I press "Update Group"
    And I press "Back to Groups"
    Then I should see "Team Hirani"

  Scenario: updating a group

    Given I am on the groups page
    When I press "View"
    And I press "Edit this Group"
    And I enter the group groupname "Team 2"
    And I press "Update Group"
    Then I should see "Group Name: Team 2"