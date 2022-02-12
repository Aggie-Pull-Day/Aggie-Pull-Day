class User < ApplicationRecord
    belongs_to :group, optional: true
    has_secure_password

    def welcome
        "Hello, #{self.email}!"
    end

    def getTeam
        results = ActiveRecord::Base.connection.execute("select groups.groupname from groups INNER JOIN users ON groups.email = '#{self.email}';")
        team = results.first["groupname"]
        members = Group.where(groupname: team)

        return members
    end
end
