namespace :TEST_SCHEDULED_TASKS do
    desc "Testing scheduled tasks with Whenever & Cron"
    task write_console: :environment do
        puts "1-minute check...\n"
    end
end