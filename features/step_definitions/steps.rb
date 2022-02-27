# frozen_string_literal: true

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'support', 'paths'))

module WithinHelpers
  def with_scope(locator, &block)
    locator ? within(locator, &block) : yield
  end
end
World(WithinHelpers)

Given /the following games exist/ do |games_table|
  games_table.hashes.each do |game|
    Game.create game
  end
end

Given /the following groups exist/ do |groups_table|
  groups_table.hashes.each do |group|
    puts group
    Group.create group
  end
end

# Given /the following users exist/ do |users_table|
#   users_table.hashes.each do |user|
#     User.create user
#   end
# end

Given /^(?:|I )am on the (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^I enter the email "(.*)"$/ do |email|
  email.downcase!
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
