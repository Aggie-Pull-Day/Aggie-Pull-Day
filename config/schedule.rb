# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
# --------------------------------------------------------------

# Attempt to fix the "/bin/bash: bundle: command not found" error
env :PATH, ENV['PATH']
# env :GEM_PATH, ENV['/home/solis/Desktop/Aggie-Pull-Day/Gemfile']

# Creates an output log for you to view previously run cron jobs
set :output, "log/cron.log"

# Sets the environment to run during development mode (Set to production by default)
set :environment, "development"

# Schedule to clear out groups after each football game
every :sunday, at: '12:00 am' do
    rake "db_scheduled_tasks:weekly_clear_groups"
end

# FOR THE SAKE OF TESTING
# every 1.minute do
#     rake "TEST_SCHEDULED_TASKS:write_console"
# end