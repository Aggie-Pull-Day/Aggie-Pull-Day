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

  def getTeam
    res = User.where(group_id: group_id)
    # results = ActiveRecord::Base.connection.execute("select groups.groupname from groups INNER JOIN users ON groups.email = '#{self.email}';")
    # puts results
    if res.empty?
      []
    else
      res
    end
  end

  def Pull
    # res = Group.where(id: group_id)
    # team = res.first['groupname']
    # members = Group.where(groupname: team)
    members = User.where(group_id: group_id)
    Group.where(id: group_id).first.update_attribute(:pulled, true)

    availableSeats = Seat.where(assigned: false)

    iterate = 0

    members.each do |member|
      member.update_attribute(:seat_id, availableSeats[iterate].id)
      availableSeats[iterate].update_attribute(:assigned, true)
      # availableSeats[iterate].update_attribute(:email, member.email)
      iterate += 1
    end
  end

  def pullTime
    this_group = Group.where(id: group_id).first
    group_class = this_group.classification

    group_members = User.where(group_id: this_group['group_id'])
    group_size = group_members.length
    num_grads = group_members.where(classification: 'U5').length
    num_seniors = group_members.where(classification: 'U4').length
    num_juniors = group_members.where(classification: 'U3').length
    num_sophomores = group_members.where(classification: 'U2').length

    this_game = Game.where(id: this_group['game_id']).first
    gamedate = this_game['gamedate']

    days_before = case group_class
                  when 'U4'
                    5
                  when 'U3'
                    4
                  when 'U2'
                    3
                  else
                    2
                  end
    pulldate = gamedate - (days_before * 60 * 60 * 24)
    Time.new(pulldate.year, pulldate.month, pulldate.day, 8, 0, 0)
  end

  def seat
    res = Seat.where(id: seat_id).first
    res['seatnumber']
  end

  def next_opponent
    this_group = Group.where(id: group_id).first
    this_game = Game.where(id: this_group['game_id']).first
    this_game['opponent']
  end
end
