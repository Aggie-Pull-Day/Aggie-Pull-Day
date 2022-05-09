class User < ApplicationRecord

  scope :filter_by_group, ->(group) { where group: group }

  belongs_to :group, optional: true
  has_one :seat
  validates_uniqueness_of :uin

  def get_uin
    student = Student.find_by(uin: uin)
    student[:uin]
  end

  def get_email
    student = Student.find_by(uin: uin)
    student[:email]
  end

  def get_first_name
    student = Student.find_by(uin: uin)
    student[:first_name]
  end

  def get_last_name
    student = Student.find_by(uin: uin)
    student[:last_name]
  end

  def get_classification
    student = Student.find_by(uin: uin)
    student[:classification]
  end

  def welcome
    "Howdy, #{get_first_name}!"
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

    @team

    # team = res.first["groupname"]

    # if team.blank?
    #     return []
    # end

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

    qr = RQRCode::QRCode.new("https://list-eaters.herokuapp.com/users/display?group=#{group_id}")

    @png_qr = qr.as_png(
      # module_px_size: 1000
    )

    require 'open-uri'
    File.open('images/image.png', 'wb') do |file|
      file.write @png_qr
    end

    #now email it
    QrMailer.with(user: self, img: @png_qr).email_sent.deliver_now

    # members.each do |member|
    #     puts member.email
    # member.update_attribute(:seatnumber, availableSeats[iterate].seatnumber)
    # member.update_attribute(:pulled, true)
    # availableSeats[iterate].update_attribute(:assigned, true)
    # availableSeats[iterate].update_attribute(:email, member.email)

    # iterate = iterate + 1
    # end
  end

  def pull_time
    this_group = Group.where(id: group_id).first
    group_class = this_group.classification

    this_game = Game.where(['gamedate > ?', DateTime.now]).order(gamedate: :asc).first
    gamedate = this_game['gamedate']

    pull_time = PullTime.find(group_class)
    days_before = (gamedate.wday + 1) % 7 + (6 - pull_time[:weekday])

    pulldate = gamedate - (days_before * 60 * 60 * 24)
    start_time = pull_time[:start_time]
    Time.new(pulldate.year, pulldate.month, pulldate.day, start_time.hour, start_time.min, start_time.sec)
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
    group = Group.find(group_id)
    group[:email] == get_email
  end

  def full_name
    first_name = get_first_name
    last_name = get_last_name
    if !first_name.nil? && !last_name.nil?
      "#{first_name} #{last_name}"
    elsif !first_name.nil?
      first_name
    elsif !last_name.nil?
      last_name
    else
      "User #{get_uin}"
    end
  end

  def group_name
    begin
      group = Group.find(group_id)
      group[:groupname]
    rescue ActiveRecord::RecordNotFound
      ''
    end
  end

  def pull_group
    group = Group.find(group_id)
    case group.classification
    when 4
      'seniors'
    when 3
      'juniors'
    when 2
      'sophomores'
    else
      'freshmen'
    end
  end
end

