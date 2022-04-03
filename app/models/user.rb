class User < ApplicationRecord
  belongs_to :group, optional: true
  has_one :seat
  has_secure_password

  def welcome
    "Hello, #{email}!"
  end

  def hasPulled
    res = Group.where(id: group_id)
    # results = ActiveRecord::Base.connection.execute("select groups.pulled from groups INNER JOIN users ON groups.email = '#{self.email}';")
    res.first.pulled
  end

  def pullTime
    this_group = Group.where(id: group_id).first
    group_members = User.where(group_id: this_group['group_id'])
    group_size = group_members.length
    num_grads = group_members.where(classification: 'U5').length
    num_seniors = group_members.where(classification: 'U4').length
    num_juniors = group_members.where(classification: 'U3').length
    num_sophomores = group_members.where(classification: 'U2').length

    this_game = Game.where(id: this_group.game_id).first
    gamedate = this_game['gamedate']

    days_before = if num_grads + num_seniors >= group_size / 2.0
                    5
                  elsif num_juniors >= group_size / 2.0
                    4
                  elsif num_sophomores >= group_size / 2.0
                    3
                  else
                    2
                  end
    pulldate = gamedate - (days_before * 60 * 60 * 24)
    Time.new(pulldate.year, pulldate.month, pulldate.day, 0, 0, 0)
  end

  def getTeam
    res = Group.where(email: email)
    # results = ActiveRecord::Base.connection.execute("select groups.groupname from groups INNER JOIN users ON groups.email = '#{self.email}';")
    # puts results
    if res.empty?
      return []
    end

    team = res.first['groupname']

    if team.blank?
      return []
    end

    members = Group.where(groupname: team)
    return members
  end

  def Pull
    res = Group.where(id: group_id)
    team = res.first['groupname']
    members = Group.where(groupname: team)

    availableSeats = Seat.where(assigned: false)

    iterate = 0

    members.each do |member|

      member.update_attribute(:seatnumber, availableSeats[iterate].seatnumber)
      member.update_attribute(:pulled, true)
      availableSeats[iterate].update_attribute(:assigned, true)
      # availableSeats[iterate].update_attribute(:email, member.email)

      iterate += 1
    end

  end

end
