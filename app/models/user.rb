class User < ApplicationRecord

    scope :filter_by_group, -> (group) {where group: group}

    belongs_to :group, optional: true
    has_one :seat
    has_secure_password

    def welcome
        "Hello, #{self.email}!"
    end

    def hasPulled

        # res = User.where(email: self.email)
        # results = ActiveRecord::Base.connection.execute("select groups.pulled from groups INNER JOIN users ON groups.email = '#{self.email}';")
        return self.pulled
    end

    def getTeam
        if self.group_id.nil?
            return []
        end
        @Team = User.where(:group_id => self.group_id)
        # results = ActiveRecord::Base.connection.execute("select groups.groupname from groups INNER JOIN users ON groups.email = '#{self.email}';")
        # puts results
        if @Team.empty?
            return []
        end

        return @Team

        # team = res.first["groupname"]

        # if team.blank?
        #     return []
        # end

        # members = Group.where(groupname: team)

        # return members
    end

    def Pull
        # res = Group.where(email: self.email)
        # team = res.first["groupname"]
        # members = Group.where(groupname: team)


        members = @Team

        ticketsToPull = members.length
        
        availableSeats = Seat.where(assigned: false)

        iterate = 0
        multi_qrcode = RQRCodeCore::QRCode.new([ #to be emailed
            { data: 'foo', mode: :byte_8bit }])        

        members.each do |member|
            puts member.email
            # member.update_attribute(:seatnumber, availableSeats[iterate].seatnumber)
            # member.update_attribute(:pulled, true)
            # availableSeats[iterate].update_attribute(:assigned, true)
            # availableSeats[iterate].update_attribute(:email, member.email)

            # iterate = iterate + 1
        end

    end

end
