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
    Then I should see "Hello, Kareemh17@tamu.edu!"
    And I should see "Kareemh17@tamu.edu NOT PULLED"

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
    Then I should see "No Group"

  Scenario: can't leave a group you aren't in

    Given I am signed in as reidneason@tamu.edu
    When I press "Leave Group"
    Then I should not see "Leave Group"

  Scenario: can't leave a group as owner

    Given I am signed in
    Then I should not see "Leave Group"

  @wip
  Scenario: remove a group member

    Given I am signed in
    When I press "Remove From Group"
    And I press the dropdown menu
    And I press "JonWaterman@tamu.edu"
    And I press "Remove"
    Then I should not see "JonWaterman@tamu.edu"

  Scenario: non-group-owner can't access remove button

    Given I am signed in as reidneason@tamu.edu
    Then I should not see "Remove From Group"

  Scenario: change groups

    Given I am signed in as reidneason@tamu.edu
    When I press "Change Groups"
    And I enter the group ID 66
    And I press "Update User"
    Then I should see "CoraEnglish@tamu.edu"