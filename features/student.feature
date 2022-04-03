Feature: have a page showing all pull groups

  As a student
  So that I can see and edit my groups
  I want to a page that shows all my groups for the current season

  Background: signed in

    Given the groups table is populated
    And the users table is populated
    And I am signed in

  Scenario: basic student/game info

    Given I am on the student page
    Then I should see "Phillip Ritchey"
    And I should see "U4"
    And I should see "Ready to Pull"
    And I should see "Remove from Group"

  Scenario: switch games

    Given I am on the student page
    When I press "TAMU vs. South Carolina"
    Then I should see "Not in Group"
    And I should see "Create Group"