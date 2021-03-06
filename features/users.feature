Feature: have a landing page showing a group

  As a student
  So that I can see relevant information on login
  I want to land on a page that shows my group for the upcoming game

  Background: database populated

    Given the database is populated

  Scenario: return to home page

    Given I am signed in
    When I press "List Eater"
    Then I should be on the home page

  Scenario: sign out

    Given I am signed in
    When I press "Sign Out"
    Then I should be on the home page

  Scenario: pull group page

    Given I am signed in
    Then I should see "Hello, Kareem!"
    And I should see "Kareem Hirani: NOT PULLED"

  Scenario: sign out

    Given I am signed in
    When I press "Sign Out"
    Then I should be on the home page

  @wip
  Scenario: pull time

    Given I am signed in
    Then I should see "BTHO Sam Houston State!"

  Scenario: leave group

    Given I am signed in as reidneason@tamu.edu
    When I press "Leave Group"
    Then I should see "You are not in a group. Create or join one below to get started!"

  Scenario: can't leave a group you aren't in

    Given I am signed in as reidneason@tamu.edu
    When I press "Leave Group"
    Then I should not see "Leave Group"

  Scenario: can't leave a group as owner

    Given I am signed in
    Then I should not see "Leave Group"

  Scenario: remove a group member

    Given I am signed in
    When I press "Remove From Group"
    Then I should not see "bbakkal97@tamu.edu"

  Scenario: non-group-owner can't access remove button

    Given I am signed in as reidneason@tamu.edu
    Then I should not see "Remove From Group"

  @wip
  Scenario: change groups

    Given I am signed in as reidneason@tamu.edu
    When I press "Change Groups"
    And I enter the group id "66"
    And I press "Update User"
    Then I should see "CoraEnglish@tamu.edu"

  Scenario: create a group

    Given I am signed in as reidneason@tamu.edu
    When I press "Leave Group"
    And I press "Create a Group"
    And I enter the group groupname "Reid's Group"
    And I press "Create Group"
    Then I should see "Reid Neason: NOT PULLED"

  Scenario: transfer group ownership

    Given I am signed in
    When I press "Make Group Owner"
    Then I should not see "Remove From Group"
    And I should see "Change Group"