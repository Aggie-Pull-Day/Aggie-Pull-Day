namespace :db_scheduled_tasks do
    desc "Tasks to clean database on a scheduled time"
    task weekly_clean: :environment do
        # delete all data entries for groups
        Group.delete_all

        # Set all of users' group_id's to nil/"" if not already
        grouped_users = User.where.not(group_id: [nil, ""])
        grouped_users.each do |gu|
            gu.group_id = nil
        end

        # Set all students seat to nil/""
        seated_users = User.where.not(seat_id: [nil, ""])
        seated_users.each do |su|
            su.seat_id = nil
        end
    end
end