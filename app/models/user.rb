class User < ApplicationRecord
    belongs_to :group, optional: true
    has_one :seat
    has_secure_password

    def welcome
        "Hello, #{self.email}!"
    end

    def hasPulled

        res = Group.where(email: self.email)
        # results = ActiveRecord::Base.connection.execute("select groups.pulled from groups INNER JOIN users ON groups.email = '#{self.email}';")
        return res.first.pulled
    end

    def getTeam
        res = Group.where(email: self.email)
        # results = ActiveRecord::Base.connection.execute("select groups.groupname from groups INNER JOIN users ON groups.email = '#{self.email}';")
        # puts results
        if res.empty?
            return []
        end

        team = res.first["groupname"]

        if team.blank?
            return []
        end

        members = Group.where(groupname: team)
        return members
    end

    def Pull
        res = Group.where(email: self.email)
        team = res.first["groupname"]
        members = Group.where(groupname: team)

        ticketsToPull = members.length

        availableSeats = Seat.where(assigned: false)

        iterate = 0

        members.each do |member|

            member.update_attribute(:seatnumber, availableSeats[iterate].seatnumber)
            member.update_attribute(:pulled, true)
            availableSeats[iterate].update_attribute(:assigned, true)
            availableSeats[iterate].update_attribute(:email, member.email)

            iterate = iterate + 1
        end

    end

end
