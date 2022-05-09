# FOR PRODUCTION ENVIRONMENT ON HEROKU
# ----
# This file (scheduler.rake) yields the same functionality as the file (db_scheduled_tasks.rake) in /lib/tasks
# This file is meant for the production environment deployed on Heroku to run using Heroku Scheduler.
# ----
# To run the automated database clearing tasks on the DEVELOPMENT environment, use the scheduler.rb file found
# in app/config/scheduler.rb in conjunction with db_scheduled_tasks.rake in app/lib/tasks

desc "Clears/deletes all entries in the database's 'Groups' table"
task weekly_clear_groups: :environment do
    if Date.today.wday.zero?
        puts "Sunday: Running clear groups"
        # Remove users from groups
        User.update_all(group_id: nil)
        puts "Set all group IDs of Users table entries to nil"

        # Delete all groups
        Group.delete_all
        puts "Deleted all entries from the Groups table in the database"

        # Remove students from seat assignments
        User.update_all(pulled: false)
        puts "Removed students seat assignments upon clearing groups"

        # Remove all ticket assignments for the next week
        Ticket.delete_all
        puts "Deletes all entries from the Tickets table in the database"
    else
        puts "Not sunday, do not clear groups"
    end
end