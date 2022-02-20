Feature: have a functional student login page

  As a student
  So that I can securely use the website
  I want a login page where I can enter my user credentials

  @wip
  Scenario: return to home page

    Given I am on the student login page
    When I press "List Eater"
    Then I should be on the home page

  @wip
  Scenario: successful login

    Given I am on the student login page
    When I enter the email "reidneason@tamu.edu"
    And I enter the password "listeater123"
    And I press "Submit"
    Then I should be on the student page

  @wip
  Scenario: incorrect password

    Given I am on the student login page
    When I enter the email "reidneason@tamu.edu"
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
