Feature: have a functional landing page

  As a user
  So that I can access the rest of the website
  I want a landing page with times for upcoming games and pulls

  Background: sign in

    Given the database is populated

  Scenario: see pull & game info
    Given I am on the home page
    Then I should see "Ticket Pull Times"
    And I should see "2022 Season"

  @wip
  Scenario: functioning student login link

    Given I am on the home page
    When I press "Log In"
    Then I should be on the student login page

  @wip
  Scenario: functioning admin login link

    Given I am on the home page
    When I press "Admin Login"
    Then I should be on the admin login page
