class User < ApplicationRecord

  scope :filter_by_group, ->(group) { where group: group }

  belongs_to :group, optional: true
  has_one :seat
  validates_uniqueness_of :uin

  def get_uin
    student = Student.where(uin: self.uin).first
    student[:uin]
  end

  def get_email
    student = Student.find_by(email: email)
    student[:email]
  end

  def get_first_name
    student = Student.find_by(first_name: first_name)
    student[:first_name]
  end

  def get_last_name
    student = Student.find_by(last_name: last_name)
    student[:last_name]
  end

  def get_classification
    student = Student.find_by(classification: classification)
    student[:classification]
  end

  def welcome
    "Hello, #{get_first_name}!"
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

  def Pull
    # res = Group.where(email: self.email)
    # team = res.first["groupname"]
    # members = Group.where(groupname: team)
    # members = @Team
    # ticketsToPull = members.length

    # availableSeats = Seat.where(assigned: false)

    iterate = 0
    multi_qrcode = RQRCodeCore::QRCode.new([#to be emailed
                                             { data: 'foo', mode: :byte_8bit }])

    qr = RQRCode::QRCode.new("https://frozen-inlet-69932.herokuapp.com/users/display?group=#{group_id}")

    @svg_qr = qr.as_svg(
      offset: 0,
      color: '000',
      shape_rendering: 'crispEdges',
      module_size: 6
    )

    require 'open-uri'
    File.open('images/image.svg', 'wb') do |file|
      file.write @svg_qr
    end

    #now email it

    QrMailer.with(user: self, img: @svg_qr).email_sent.deliver_later

    # members.each do |member|
    #     puts member.email
    # member.update_attribute(:seatnumber, availableSeats[iterate].seatnumber)
    # member.update_attribute(:pulled, true)
    # availableSeats[iterate].update_attribute(:assigned, true)
    # availableSeats[iterate].update_attribute(:email, member.email)

    # iterate = iterate + 1
    # end
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
    if Game.all.length.positive?
      this_game = Game.where(['gamedate > ?', DateTime.now]).order(gamedate: :asc).first
      this_game['opponent']
    end
  end

  def group_owner?
    group = Group.where(id: group_id).first
    group[:email] == email
  end

  def dropdown_options
    members = getTeam.where.not(email: email)
    members.collect do |member|
      [member[:email], member[:id]]
    end
  end

  def full_name
    if !first_name.nil? && !last_name.nil?
      "#{first_name} #{last_name}"
    elsif !first_name.nil?
      first_name
    elsif !last_name.nil?
      last_name
    else
      'Anonymous User'
    end
  end
end

