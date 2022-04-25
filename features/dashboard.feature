Feature: admin dashboard

  As an administrator
  So that I can use my CRUD privileges
  I want a dashboard that gives me access to all the site's data

  Background: database populated & signed in

    Given the database is populated
    And I am signed in as drritchey@tamu.edu
    And I am on the admin dashboard


  Scenario: basic site statistics
    Then I should see "upcoming games"
    And I should see "active groups"
    And I should see "registered users"

  Scenario: button to access games
    When I press "Games"
    Then I should be on the games page

  Scenario: button to access groups
    When I press "Groups"
    Then I should be on the groups page

  Scenario: button to access admin users page
    When I press "Users"
    Then I should be on the users page
    And I should see "Students"
    And I should see "Admins"