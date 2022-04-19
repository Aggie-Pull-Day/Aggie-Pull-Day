class User < ApplicationRecord

  scope :filter_by_group, ->(group) { where group: group }

  belongs_to :group, optional: true
  has_one :seat
  has_secure_password

  def welcome
    "Hello, #{email}!"
  end

  def hasPulled
    # res = User.where(email: self.email)
    # results = ActiveRecord::Base.connection.execute("select groups.pulled from groups INNER JOIN users ON groups.email = '#{self.email}';")
    pulled
  end

  def getTeam
    return [] if group_id.nil?

    @team = User.where(group_id: group_id)
    # results = ActiveRecord::Base.connection.execute("select groups.groupname from groups INNER JOIN users ON groups.email = '#{self.email}';")
    # puts results
    return [] if @team.empty?

    return @team

    # team = res.first["groupname"]

    # if team.blank?
    #     return []
    # end

    # members = Group.where(groupname: team)

    # return members
  end

  end

  def pullTime
    this_group = Group.where(id: group_id).first
    group_class = this_group.classification

    this_game = Game.where(['gamedate > ?', DateTime.now]).order(gamedate: :asc).first
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
    this_game = Game.where(['gamedate > ?', DateTime.now]).order(gamedate: :asc).first
    this_game['opponent']
  end
end
