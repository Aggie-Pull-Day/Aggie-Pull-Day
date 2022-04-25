Feature: editing list of games

  As an admin
  So that students can form groups for upcoming games
  I want the ability to add and remove game data

  Background: games in database

    Given the database is populated
    And I am signed in

  @wip
  Scenario: return to home page

    Given I am on the games page
    When I press "List Eater"
    Then I should be on the home page

  Scenario: view a game

    Given I am on the games page
    When I press "View Details"
    Then I should see "Hometeam:"
    And I should see "Opponent:"
    And I should see "Gamedate:"
    And I should see "Day:"

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
    Then I should see "TAMU vs. Alabama"

  Scenario: adding new game

    Given I am on the game page
    When I press "New game"
    And I enter the game hometeam "TAMU"
    And I enter the game opponent "Ole Miss"
    And I enter the game gamedate "2022-09-24 00:00:00 UTC"
    And I enter the game day "Saturday"
    And I press "Create Game"
    Then I should see "Hometeam: TAMU"
    And I should see "Opponent: Ole Miss"
    And I should see "Gamedate: 2022-09-24 00:00:00 UTC"
    And I should see "Day: Saturday"

  Scenario: deleting a game

    Given I am on the game page
    When I press "View Details"
    And I press "Delete this Game"
    Then I should see "Game was successfully destroyed."