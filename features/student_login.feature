Feature: have a functional student login page

  As a student
  So that I can securely use the website
  I want a login page where I can enter my user credentials

#  Background: users in database
#
#    Given the following users exist:
#      | email             | password_digest
#      | KareemH@tamu.edu  | Dummy
#      | ReidN@tamu.edu    | Dummy2
#      | BaldwinB@tamu.edu | Dummy3
#      | JonW@tamu.edu     | Dummy4

  @wip
  Scenario: return to home page

    Given I am on the student login page
    When I press "List Eater"
    Then I should be on the home page

  @wip
  Scenario: successful login

    Given I am on the student login page
    When I enter the email "KareemH@tamu.edu"
    And I enter the password "Dummy"
    And I press "Sign In!"
    Then I should see "Hello, KareemH@tamu.edu!"

  @wip
  Scenario: incorrect password

    Given I am on the student login page
    When I enter the email "KareemH@tamu.edu"
    And I enter the password "listeater124"
    And I press "Submit"
    Then I should see "Incorrect password"

  @wip
  Scenario: email not a user

    Given I am on the student login page
    When I enter the email "twopercenter@tamu.edu"
    And I enter the password "lol"
    And I press "Submit"
    Then I should see "That email address is not associated with a user"

  @wip
  Scenario: improperly formatted email

    Given I am on the student login page
    When I enter the email "notanemail"
    And I enter the password "doesntmatter"
    And I press "Submit"
    Then I should see "Please put an email address"

  @wip
  Scenario: create an account

    Given I am on the student login page
    When I press "Sign Up"
    And I enter the new email "PhilipR@tamu.edu"
    And I enter the new password "OldArmy"
    And I press "Create Account"
    Then I should see "Hello, PhilipR@tamu.edu!"
    And I should see "No Team"

  @wip
  Scenario: sign out

    Given I am on the student login page
    When I enter the email "KareemH@tamu.edu"
    And I enter the password "listeater124"
    And I press "Submit"
    And I press "Sign out"
    Then I should be on the student login page
