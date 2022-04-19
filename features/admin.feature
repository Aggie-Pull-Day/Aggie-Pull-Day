Feature: have an admin page with pull stats

  As an admin
  So that I can see ticket pull statistics
  I want an admin page with tickets sorted by game and season

  Background: signed in

    Given the groups table is populated
    And the users table is populated
    And I am signed in

  @wip
  Scenario: return to home page

    Given I am on the admin page
    When I press "List Eater"
    Then I should be on the home page

  @wip
  Scenario: change season

    Given I am on the admin page
    When I press "Select Season"
    And I press "2020"
    Then I should see "2020 Season Football Statistics"

  @wip
  Scenario: change games

    Given I am on the admin page
    When I press "Select Season"
    And I press "2021"
    And I press "TAMU vs. South Carolina"
    Then I should see "Saturday, October 23"

  @wip
  Scenario: export game statistics

    Given I am on the admin page
    When I press "Select Season"
    And I press "2021"
    And I press "TAMU vs. South Carolina"
    And I press "Export Game Data"
    Then I should download a file called "tamu_vs_south_carolina_2021_pull_stats.csv"

  @wip
  Scenario: export season statistics

    Given I am on the admin page
    When I press "Select Season"
    And I press "2021"
    And I press "Export Season Data"
    Then I should download a file called "tamu_2021_season_pull_stats.csv"