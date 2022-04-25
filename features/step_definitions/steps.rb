# frozen_string_literal: true

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'support', 'paths'))

module WithinHelpers
  def with_scope(locator, &block)
    locator ? within(locator, &block) : yield
  end
end
World(WithinHelpers)

Given /^I am signed in(?: as ([^"]*))?$/ do |email|
  visit '/sessions/new'
  fill_in('email', with: email.nil? ? 'kareemh17@tamu.edu' : email)
  fill_in('password', with: 'Dummy')
  click_button('Sign In!')
end

Given /^the database is populated$/ do
  games = [{ opponent: 'Sam Houston State', gamedate: '3-Sep-2022' },
           { opponent: 'App State', gamedate: '10-Sep-2022' },
           { opponent: 'Miami (FL)', gamedate: '17-Sep-2022' }]
  games.each do |game|
    Game.create!(game) if Game.where(opponent: game['opponent']).empty?
  end

  groups = [{ groupname: 'List Eaters', owner: 'Kareem Hirani', pulled: false, email: 'kareemh17@tamu.edu' },
            { groupname: 'Team 1', owner: 'Cora English', pulled: false, email: 'CoraEnglish@tamu.edu' }]
  groups.each do |group|
    Group.create!(group) if Group.where(groupname: group['groupname']).empty?
  end

  users = [{ email: 'kareemh17@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), pulled: false,
             group_id: Group.first[:id], uin: 327001001, classification: 'U4', admin: false },
           { email: 'bbakkal97@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), pulled: false,
             group_id: Group.first[:id], uin: 327001002, classification: 'U4', admin: false },
           { email: 'jonrwaterman@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), pulled: false,
             group_id: Group.first[:id], uin: 327001003, classification: 'U4', admin: false },
           { email: 'reidneason@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), pulled: false,
             group_id: Group.first[:id], uin: 327001004, classification: 'U4', admin: false },
           { email: 'CoraEnglish@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), pulled: false,
             group_id: Group.last[:id], uin: 327001005, classification: 'U4', admin: false },
           { email: 'GraceLi@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), pulled: false,
             group_id: Group.last[:id], uin: 327001006, classification: 'U4', admin: false },
           { email: 'RebeccaMcfadden@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), pulled: false,
             group_id: Group.last[:id], uin: 327001007, classification: 'U4', admin: false },
           { email: 'drritchey@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), pulled: false,
             group_id: nil, uin: 1, classification: 'U5', admin: true }]
  users.each do |user|
    User.create!(user) if User.where(uin: user['uin']).empty?
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
  fill_in('group_pulled', with: pulled)
end

When /^I enter the group ID (\d*)$/ do |id|
  fill_in('user[group_id]', with: id)
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
