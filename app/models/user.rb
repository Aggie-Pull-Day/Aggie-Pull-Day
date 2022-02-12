class User < ApplicationRecord
    belongs_to :group, optional: true
    has_secure_password

    def welcome
        "Hello, #{self.email}!"
    end

    def getTeam
        results = ActiveRecord::Base.connection.execute("select groups.groupname from groups INNER JOIN users ON groups.email = '#{self.email}';")
        puts results
        if results.num_tuples.zero?
            return []
        end

        team = results.first["groupname"]

        if team.blank?
            return []
        end

        members = Group.where(groupname: team)
        return members
    end
end
