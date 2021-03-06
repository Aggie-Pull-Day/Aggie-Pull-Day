# frozen_string_literal: true

# Taken from the cucumber-rails project.

module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    when /home\s?page/
      '/articles'
    when /students? page/
      '/student'
    when /admin page/
      '/admin'
    when /student log[\s-]?in page/
      '/sessions/new'
    when /admin log[\s-]?in page/
      '/admin-login'
    when /games? page/
      '/games'
    when /groups? page/
      '/groups'
    when /users? page/
      '/users'
    when /pull group page/
      "/users/#{User.first[:id]}"
    when /admin dashboard/
      '/dashboard'
      # Add more mappings here.
      # Here is an example that pulls values out of the Regexp:
      #
      #   when /^(.*)'s profile page$/i
      #     user_profile_path(User.find_by_login($1))
    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" \
            "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
