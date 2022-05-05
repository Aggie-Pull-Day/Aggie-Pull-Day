# frozen_string_literal: true

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'support', 'paths'))

module WithinHelpers
  def with_scope(locator, &block)
    locator ? within(locator, &block) : yield
  end
end
World(WithinHelpers)

Given(/^I am signed in(?: as ([^"]*))?$/) do |email|
  visit '/sessions/new'
  fill_in('email', with: email.nil? ? 'kareemh17@tamu.edu' : email)
  fill_in('password', with: 'Dummy')
  click_button('Sign In!')
end

Given /^the database is populated$/ do
  more_games = [
    { opponent: 'Sam Houston State', gamedate: '3-Sep-2022' },
    { opponent: 'App State', gamedate: '10-Sep-2022' },
    { opponent: 'Miami (FL)', gamedate: '17-Sep-2022' }
  ]
  more_games.each do |game|
    Game.create!(game)
  end

  more_groups = [
    { groupname: 'List Eaters', owner: 'Kareem Hirani', pulled: false, email: 'kareemh17@tamu.edu' },
    { groupname: 'Team 1', owner: 'Cora English', pulled: false, email: 'CoraEnglish@tamu.edu' }
  ]
  more_groups.each do |group|
    Group.create!(group)
  end

  more_users = [
    { uin: 327001001, pulled: false, group_id: Group.first.id, admin: false },
    { uin: 327001002, pulled: false, group_id: Group.first.id, admin: false },
    { uin: 327001003, pulled: false, group_id: Group.first.id, admin: false },
    { uin: 327001004, pulled: false, group_id: Group.first.id, admin: false },
    { uin: 327001005, pulled: false, group_id: Group.last.id, admin: false },
    { uin: 327001006, pulled: false, group_id: Group.last.id, admin: false },
    { uin: 327001007, pulled: false, group_id: Group.last.id, admin: false },
    { uin: 1, pulled: false, group_id: nil, admin: true }
  ]
  more_users.each do |user|
    User.create!(user)
  end

  more_students = [
    { uin: 327001001, email: 'kareemh17@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
      first_name: 'Kareem', last_name: 'Hirani', classification: 'U4' },
    { uin: 327001002, email: 'bbakkal97@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
      first_name: 'Baldwin', last_name: 'Bakkal', classification: 'U4' },
    { uin: 327001003, email: 'jonrwaterman@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
      first_name: 'Jon', last_name: 'Waterman', classification: 'U4' },
    { uin: 327001004, email: 'reidneason@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
      first_name: 'Reid', last_name: 'Neason', classification: 'U4' },
    { uin: 327001005, email: 'CoraEnglish@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
      first_name: 'Cora', last_name: 'English', classification: 'U4' },
    { uin: 327001006, email: 'GraceLi@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), first_name: 'Grace',
      last_name: 'Li', classification: 'U4' },
    { uin: 327001007, email: 'RebeccaMcfadden@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
      first_name: 'Rebecca', last_name: 'McFadden', classification: 'U4' },
    { uin: 327001008, email: 'matthewwaterman@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
      first_name: 'Matthew', last_name: 'Waterman', classification: 'U1' },
    { uin: 327001009, email: 'jaketraylor@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
      first_name: 'Jake', last_name: 'Traylor', classification: 'U1' },
    { uin: 1, email: 'drritchey@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
      first_name: 'Philip', last_name: 'Ritchey', classification: 'U5' }
  ]
  more_students.each do |student|
    Student.create!(student)
  end
end

Given(/^(?:|I )am on the (.+)$/) do |page_name|
  visit path_to(page_name)
end

When /^I check the box$/ do
  find(:css, "#group_pulled", visible: false).execute_script('this.checked = true')
end

When /^I enter the(?: ([\S]*))? (.*) "(.*)"$/ do |form, field, value|
  element = if form.nil?
              field
            else
              "#{form}#{}[#{field.gsub(/\s/, '_')}]"
            end
  fill_in(element, with: value)
end

When(/^(?:|I )press "([^"]*)"(?: within "([^"]*)")?$/) do |button, selector|
  with_scope(selector) do
    click_link_or_button(button, match: :first)
  end
end

Then(/^(?:|I )should be on the (.+)$/) do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Then(/^(?:|I )should see "([^"]*)"(?: within "([^"]*)")?$/) do |text, selector|
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_content(text)
    else
      assert page.has_content?(text)
    end
  end
end

Then(/^I should download a file called "(.*)"$/) do |fname|
  page.response_headers['Content-Disposition'].should include "filename=" # {fname}""
end

Then(/^(?:|I )should not see "([^"]*)"(?: within "([^"]*)")?$/) do |text, selector|
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_no_content(text)
    else
      assert !page.has_content?(text)
    end
  end
end
