Feature: groups page for upcoming games

  As a student
  So that I can join, create, and leave groups
  I want a webpage that will display info about my groups and allow me to edit it

Scenario: return to home page

  Given I am on the groups page
  When I press "List Eater"
  Then I should be on the home page

Scenario: view a group

  Given I am on the groups page
  When I press "View"
  Then I should see "Groupname:"
  And I should see "Member:"
  And I should see "Pulled:"

Scenario: create a new group

  Given I am on the groups page
  When I press "New group"
  And I enter the groupname "TAMU vs LSU Group"
  And I enter the member "Reid Neason"
  And I enter the pulled status "false"
  Then I should see "Group was successfully created."

Scenario: deleting a group

  Given I am on the groups page
  When I press "View"
  And I press "Destroy this Group"
  Then I should see "Group was successfully destroyed."

Scenario: updating a group

  Given I am on the groups page
  When I press "View"
  And I press "Edit this Game"
  And I enter the group name "Team 2"
  And I press "Update Group"
  Then I should see "Groupname: Team 2"