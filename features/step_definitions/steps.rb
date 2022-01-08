# frozen_string_literal: true

require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
  def with_scope(locator, &block)
    locator ? within(locator, &block) : yield
  end
end
World(WithinHelpers)

Given /^(?:|I )am on the (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )press "([^\"]*)"$/ do |button|
  click_button(button)
end

When /^I enter the email "(.*)"$/ do |email|
  email.downcase!
  fill_in('email', with: email)
end

When /^I enter the password "(.*)"$/ do |pw|
  pw.downcase!
  fill_in('password', with: pw)
end

Then /^(?:|I )should be on the (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Then /^(?:|I )should see "([^\"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end
