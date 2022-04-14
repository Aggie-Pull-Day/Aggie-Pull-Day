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

  games.each_with_index do |game, index|
    game['id'] = index + 1
    Game.create!(game) if Game.where(opponent: game['opponent']).empty?
  end
end

Given /^the groups table is populated$/ do
  groups = [{ groupname: 'List Eaters', pulled: false, game_id: 1 },
            { groupname: 'Team 1', pulled: false, game_id: 1 }]

  groups.each_with_index do |group, index|
    group['id'] = index + 1
    Group.create!(group) if Group.where(groupname: group['groupname']).empty?
  end
end

Given /^the users table is populated$/ do
  users = [
    { email: 'KareemH@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), classification: 'U4', group_id: 1,
      seat_id: nil },
    { email: 'BaldwinB@tamu.edu', password_digest: 'Dummy', classification: 'U4', group_id: 1, seat_id: nil },
    { email: 'ReidN@tamu.edu', password_digest: 'Dummy', classification: 'U4', group_id: 1, seat_id: nil },
    { email: 'JonW@tamu.edu', password_digest: 'Dummy', classification: 'U4', group_id: 1, seat_id: nil },
    { email: 'CoraE@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), classification: 'U4', group_id: 2,
      seat_id: nil },
    { email: 'GraceL@tamu.edu', password_digest: 'Dummy', classification: 'U4', group_id: 2, seat_id: nil },
    { email: 'RebeccaF@tamu.edu', password_digest: 'Dummy', classification: 'U4', group_id: 2, seat_id: nil },
    { email: 'NikhitaV@tamu.edu', password_digest: 'Dummy', classification: 'U4', group_id: 2, seat_id: nil }
  ]

  users.each_with_index do |user, index|
    user['id'] = index + 1
    User.create!(user) if User.where(email: user['email']).empty?
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