namespace :scheduled_db_clean do
    desc "Clean ticket pull groups weekly on Sunday morning"
    task weekly_clean: :environment do
        # Delete all data entries for groups
        Group.delete_all
        puts "Deleted group table entries from database"

        # Set all of users' group_id's to nil/"" if not already
        grouped_users = User.where.not(group_id: [nil, ""])
        grouped_users.each do |gu|
            gu.group_id = nil
        end
        puts "Cleared users' groups"

        # Set all students seat to nil/""
        seated_users = User.where.not(seat_id: [nil, ""])
        seated_users.each do |su|
            su.seat_id = nil
        end
        puts "Cleared users' seat assignments"

        # Set all students to a default of "Not Pulled"
        pulled_users = User.where(pulled: true)
        users.each do |pu|
            pu.pulled = false
        end
        puts "Reset users' pull status to FALSE"
    end
end