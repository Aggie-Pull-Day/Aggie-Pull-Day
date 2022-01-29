Feature: have an admin page with pull stats

  As an admin
  So that I can see ticket pull statistics
  I want an admin page with tickets sorted by game and season

Scenario: return to home page

  Given I am on the admin page
  When I press "List Eater"
  Then I should be on the home page

Scenario: change season

  Given I am on the admin page
  When I press "Select Season"
  And I press "2020"
  Then I should see "2020 Season Football Statistics"

Scenario: change games

  Given I am on the admin page
  When I press "Select Season"
  And I press "2021"
  And I press "TAMU vs. South Carolina"
  Then I should see "Game Date: Saturday, October 23rd"

Scenario: export statistics

  Given I am on the admin page
  When I press "Select Season"
  And I press "2021"
  And I press "TAMU vs. South Carolina"
  And I press "Export Game Data"
  Then I should download a file called "tamu_vs_south_carolina_2021_pull_stats.csv"