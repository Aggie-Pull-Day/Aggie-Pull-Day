Feature: have a functional student login page

  As a student
  So that I can securely use the website
  I want a login page where I can enter my user credentials

  Background: users in database

    Given the database is populated

  @wip
  Scenario: return to home page

    Given I am on the student login page
    When I press "List Eater"
    Then I should be on the home page


  Scenario: successful login

    Given I am on the student login page
    When I enter the email "kareemh17@tamu.edu"
    And I enter the password "Dummy"
    And I press "Sign In!"
    Then I should see "Hello, Kareem!"

  Scenario: incorrect password

    Given I am on the student login page
    When I enter the email "kareemh17@tamu.edu"
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

  @wip
  Scenario: create an account

    Given I am on the student login page
    When I press "Sign Up"
    And I enter the user first name "Robert"
    And I enter the user last name "Lightfoot"
    And I enter the user email "roblight@tamu.edu"
    And I enter the user password "OldArmy"
    And I press "Create Account"
    Then I should see "Hello, Robert!"
    And I should see "No Group"
