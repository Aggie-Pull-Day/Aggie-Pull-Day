namespace :db_scheduled_tasks do
  desc "Clears/deletes all entries in the database's 'Groups' table"
  task weekly_clear_groups: :environment do

    # Remove users from groups
    User.update_all(group_id: nil)
    puts "Set all group IDs of Users table entries to nil"

    # Delete all groups
    Group.delete_all
    puts "Deleted all entries from the Groups table in the database"

    # Remove students from seat assignments
    User.update_all(pulled: false)
    puts "Removed students seat assignments upon clearing groups"
  end    
end
