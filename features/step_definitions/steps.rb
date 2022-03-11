# frozen_string_literal: true

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'support', 'paths'))

module WithinHelpers
  def with_scope(locator, &block)
    locator ? within(locator, &block) : yield
  end
end
World(WithinHelpers)

Given /^I am signed in$/ do
  visit '/sessions/new'
  fill_in('email', with: 'KareemH@tamu.edu')
  fill_in('password', with: 'Dummy')
  click_button('Sign In!')
  visit '/users/1'
end

Given /^the games table is populated$/ do
  games = [{ hometeam: 'TAMU', opponent: 'Sam Houston State', gamedate: '3-Sep-2022', day: 'Saturday' },
           { hometeam: 'TAMU', opponent: 'App State', gamedate: '10-Sep-2022', day: 'Saturday' },
           { hometeam: 'TAMU', opponent: 'Miami (FL)', gamedate: '17-Sep-2022', day: 'Thursday' }]

  games.each do |game|
    Game.create!(game)
  end
end

Given /^the groups table is populated$/ do
  groups = [
    { groupname: 'List Eaters', member: 'Kareem Hirani', pulled: false, email: 'KareemH@tamu.edu' },
    { groupname: 'List Eaters', member: 'Baldwin Bakkal', pulled: false, email: 'BaldwinB@tamu.edu' },
    { groupname: 'List Eaters', member: 'Reid Neason', pulled: false, email: 'ReidN@tamu.edu' },
    { groupname: 'List Eaters', member: 'Jon Waterman', pulled: false, email: 'JonW@tamu.edu' },
    { groupname: 'Team 1', member: 'Cora English', pulled: false, email: 'CoraE@tamu.edu' },
    { groupname: 'Team 1', member: 'Grace Li', pulled: false, email: 'GraceL@tamu.edu' },
    { groupname: 'Team 1', member: 'Rebecca McFadden', pulled: false, email: 'RebeccaF@tamu.edu' },
    { groupname: 'Team 1', member: 'Nikhita Vehmpati', pulled: false, email: 'NikhitaV@tamu.edu' }
  ]

  groups.each do |group|
    Group.create!(group)
  end
end

Given /^the users table is populated$/ do
  users = [
    { email: 'KareemH@tamu.edu', password_digest: BCrypt::Password.create('Dummy') },
    { email: 'BaldwinB@tamu.edu', password_digest: BCrypt::Password.create('Dummy') },
    { email: 'ReidN@tamu.edu', password_digest: BCrypt::Password.create('Dummy') },
    { email: 'JonW@tamu.edu', password_digest: BCrypt::Password.create('Dummy') },
    { email: 'CoraE@tamu.edu', password_digest: BCrypt::Password.create('Dummy') },
    { email: 'GraceL@tamu.edu', password_digest: BCrypt::Password.create('Dummy') },
    { email: 'RebeccaM@tamu.edu', password_digest: BCrypt::Password.create('Dummy') },
    { email: 'NikhitaV@tamu.edu', password_digest: BCrypt::Password.create('Dummy') }
  ]

  users.each do |user|
    User.create!(user)
  end
end

Given /^(?:|I )am on the (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^I enter the email "(.*)"$/ do |email|
  fill_in('email', with: email)
end

When /^I enter the password "(.*)"$/ do |pw|
  fill_in('password', with: pw)
end

When /^I enter the opponent "(.*)"$/ do |opp|
  fill_in('game[opponent]', with: opp)
end

When /^I enter the home[\s-]?team "(.*)"$/ do |home|
  fill_in('game[hometeam]', with: home)
end

When /^I enter the game[\s]?date "(.*)"$/ do |date|
  fill_in('game[gamedate]', with: date)
end

When /^I enter the day "(.*)"$/ do |day|
  fill_in('game[day]', with: day)
end

When /^I enter the group[\s]?name "(.*)"$/ do |gn|
  fill_in('group[groupname]', with: gn)
end

When /^I enter the member "(.*)"$/ do |member|
  fill_in('group[member]', with: member)
end

When /^I enter the pulled status "(.*)"$/ do |pulled|
  fill_in('group[pulled]', with: pulled)
end

When /^I enter the new email "(.*)"$/ do |email|
  fill_in('user[email]', with: email)
end

When /^I enter the new password "(.*)"$/ do |pw|
  fill_in('user[password]', with: pw)
end

When /^(?:|I )press "([^\"]*)"(?: within "([^\"]*)")?$/ do |button, selector|
  with_scope(selector) do
    click_link_or_button(button, match: :first)
  end
end

Then /^(?:|I )should be on the (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Then /^(?:|I )should see "([^\"]*)"(?: within "([^\"]*)")?$/ do |text, selector|
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_content(text)
    else
      assert page.has_content?(text)
    end
  end
end

Then /^I should download a file called "(.*)"$/ do |fname|
  page.response_headers['Content-Disposition'].should include "filename=\"#{fname}\""
end

Then /^(?:|I )should not see "([^\"]*)"(?: within "([^\"]*)")?$/ do |text, selector|
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_no_content(text)
    else
      assert !page.has_content?(text)
    end
  end
end