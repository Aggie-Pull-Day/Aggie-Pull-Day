Feature: have a page showing all pull groups

  As a student
  So that I can see and edit my groups
  I want to a page that shows all my groups for the current season

  Background: signed in

    Given the groups table is populated
    And the users table is populated
    And I am signed in

  Scenario: basic student/game info

    Given I am on the student page
    Then I should see "Phillip Ritchey"
    And I should see "U4"
    And I should see "Ready to Pull"
    And I should see "Remove from Group"

  Scenario: switch games

    Given I am on the student page
    When I press "TAMU vs. South Carolina"
    Then I should see "Not in Group"
    And I should see "Create Group"

  @wip
  Scenario: add to group by email

    Given I am on the student page
    When I press "Add to Group"
    And I press "Add Emails"
    And I enter the email "PhilipR@tamu.edu"
    And I press "Invite"
    Then I should see "Email sent!"

  @wip
  Scenario: add to group by invite link

    Given I am on the student page
    When I press "Add to Group"
    And I press "Copy Invite Link"
    Then I should see "Link successfully copied!"

  @wip
  Scenario: remove from group

    Given I am on the student page
    And I am the group owner
    When I check the box on "Baldwin Bakkal"
    And I press "Remove from Group"
    Then I should not see "Baldwin Bakkal" within "group"

  @wip
  Scenario: leave from group
    Given I am on the student page
    And I press "Leave Group"
    And I press "Confirm"
    Then I should see "Not in Group"

  @wip
  Scenario: Group is ready to pull
    Given I am on the student page
    And I am the group owner
    When I press "Ready to Pull"
    Then I should see "Group is locked. Ready to pull."
    And I should not see "Add to Group"
    And I should not see "Remove from Group"
    And I should not see "Leave Group"