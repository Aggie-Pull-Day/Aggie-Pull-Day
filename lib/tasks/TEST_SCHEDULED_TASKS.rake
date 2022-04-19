namespace :TEST_SCHEDULED_TASKS do
    desc "Testing out the Whenever/Cron Gem to make sure it works on a basic level"
    task write_console: :environment do
        puts "1-minute check...\n"
    end
end