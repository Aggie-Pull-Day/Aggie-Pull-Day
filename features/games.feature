Feature: editing list of games

  As an admin
  So that students can form groups for upcoming games
  I want the ability to add and remove game data

  Background: games in database

    Given the database is populated
    And I am signed in as drritchey@tamu.edu

  Scenario: return to home page

    Given I am on the games page
    When I press "List Eater"
    Then I should be on the home page

  Scenario: sign out

    Given I am on the games page
    When I press "Sign Out"
    Then I should be on the home page

  Scenario: view a game

    Given I am on the games page
    When I press "View Details"
    And I should see "Opponent:"
    And I should see "Start Time:"

  Scenario: access edit game page

    Given I am on the games page
    When I press "View Details"
    And I press "Edit this Game"
    Then I should see "Editing Game"

  Scenario: game change reflected on info page

    Given I am on the games page
    When I press "View Details"
    And I press "Edit this Game"
    And I enter the game opponent "LSU"
    And I press "Update Game"
    Then I should see "Opponent: LSU"

  Scenario: game change reflected on games page

    Given I am on the games page
    When I press "View Details"
    And I press "Edit this Game"
    And I enter the game opponent "Alabama"
    And I press "Update Game"
    And I press "Back to Games"
    Then I should see "Alabama"

  Scenario: adding new game

    Given I am on the game page
    When I press "New game"
    And I enter the game opponent "Ole Miss"
    And I enter the game gamedate "2022-09-24 00:00:00 UTC"
    And I press "Create Game"
    And I should see "Opponent: Ole Miss"
    And I should see "Start Time: September 24, 2022 at 12:00 AM"

  Scenario: deleting a game

    Given I am on the game page
    When I press "View Details"
    And I press "Delete this Game"
    Then I should see "Game was successfully destroyed."