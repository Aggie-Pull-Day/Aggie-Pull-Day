Feature: have a functional landing page

  As a user
  So that I can access the rest of the website
  I want a login page with times for upcoming games and pulls

Scenario: functioning student login link

  Given I am on the home page
  When I press "Student Login"
  Then I should be on the student login page

Scenario: functioning admin login link

    Given I am on the home page
    When I press "Admin Login"
    Then I should be on the admin login page
