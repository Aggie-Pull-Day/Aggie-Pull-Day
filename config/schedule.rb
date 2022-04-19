# --------------------------------------------------------------
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

# Creates an output log for you to view previously run cron jobs
set :output, "log/cron.log"

# Sets the environment to run during development mode (Set to production by default)
set :environment, "development"

# Set path to files containing tasks to run
# set :path, "/home/solis/Desktop/Aggie-Pull-Day"

# Schedule to clear out groups after each football game
# THIS NEEDS TO BE UNCOMMENTED AFTER SHOWING RITCHEY
# every :sunday, at '12:00 am' do
#     rake "db_scheduled_tasks:weekly_clean"
# end

# FOR THE SAKE OF TESTING
every 1.minute do
    rake "TEST_SCHEDULED_TASKS:write_console"
    # command "echo 'Printing every 1-minute interval'"
end