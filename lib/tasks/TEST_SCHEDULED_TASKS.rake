namespace :TEST_SCHEDULED_TASKS do
    desc "Testing out the Whenever/Cron Gem to make sure it works on a basic level"
    task write_console: :environment do
        puts "Just wrote something to the console. I will write again in 1-minute\n"
        puts "...\n"
    end
end