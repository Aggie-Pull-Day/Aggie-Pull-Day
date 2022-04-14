Feature: have a functional student login page

  As a student
  So that I can securely use the website
  I want a login page where I can enter my user credentials

  Background: users in database

    Given the groups table is populated
    And the users table is populated

  @wip
  Scenario: return to home page

    Given I am on the student login page
    When I press "List Eater"
    Then I should be on the home page


  Scenario: successful login

    Given I am on the student login page
    When I enter the email "KareemH@tamu.edu"
    And I enter the password "Dummy"
    And I press "Sign In!"
    Then I should see "Hello, KareemH@tamu.edu!"

  Scenario: incorrect password

    Given I am on the student login page
    When I enter the email "KareemH@tamu.edu"
    And I enter the password "listeater124"
    And I press "Sign In!"
    Then I should be on the student login page

  Scenario: email not a user

    Given I am on the student login page
    When I enter the email "twopercenter@tamu.edu"
    And I enter the password "lol"
    And I press "Sign In!"
    Then I should be on the student login page

  @wip
  Scenario: improperly formatted email

    Given I am on the student login page
    When I enter the email "notanemail"
    And I enter the password "doesntmatter"
    And I press "Sign In!"
    Then I should see "Please put an email address"

  Scenario: create an account

    Given I am on the student login page
    When I press "Sign Up"
    And I enter the new email "PhilipR@tamu.edu"
    And I enter the new password "OldArmy"
    And I press "Create Account"
    Then I should see "Hello, PhilipR@tamu.edu!"
    And I should see "No Team"
