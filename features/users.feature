Feature: have a landing page showing a group

  As a student
  So that I can see relevant information on login
  I want to land on a page that shows my group for the upcoming game

  Background: database populated

    Given the database is populated

  @wip
  Scenario: return to home page

    Given I am signed in
    When I press "List Eater"
    Then I should be on the home page

  Scenario: pull group page

    Given I am signed in
    Then I should see "Hello, Kareemh17@tamu.edu!"
    And I should see "Kareemh17@tamu.edu NOT PULLED"

  Scenario: sign out

    Given I am signed in
    When I press "Sign out"
    Then I should be on the student login page

  @wip
  Scenario: pull time

    Given I am signed in
    Then I should see "BTHO Sam Houston State!"