# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
more_games = [
  { opponent: 'Kent State', gamedate: '4-Sep-2021 7:00 PM' },
  { opponent: 'New Mexico', gamedate: '18-Sep-2021 11:00 AM' },
  { opponent: 'Mississippi State', gamedate: '2-Oct-2021 6:00 PM' },
  { opponent: 'Alabama', gamedate: '9-Oct-2021 7:00 PM' },
  { opponent: 'South Carolina', gamedate: '23-Oct-2021 6:30 PM' },
  { opponent: 'Auburn', gamedate: '6-Nov-2021 2:30 PM' },
  { opponent: 'Prairie View A&M', gamedate: '20-Nov-2021 11:00 AM' },
  { opponent: 'Sam Houston State', gamedate: '3-Sep-2022' },
  { opponent: 'Appalachian State', gamedate: '10-Sep-2022' },
  { opponent: 'Miami (FL)', gamedate: '17-Sep-2022' },
  { opponent: 'Ole Miss', gamedate: '29-Oct-2022' },
  { opponent: 'Florida', gamedate: '5-Nov-2022' },
  { opponent: 'UMass', gamedate: '19-Nov-2022' },
  { opponent: 'LSU', gamedate: '26-Nov-2022' },
  { opponent: 'New Mexico', gamedate: '2-Sep-2023' },
  { opponent: 'Louisiana-Monroe', gamedate: '16-Sep-2023' },
  { opponent: 'Abilene Christian', gamedate: '18-Nov-2023' }
]

more_games.each do |game|
  Game.create!(game)
end

# works for single user

more_groups = [
  { groupname: 'List Eaters', owner: 'Kareem Hirani',
    pulled: false, email: 'kareemh17@tamu.edu' },
  { groupname: 'Team 1', owner: 'Cora English',
    pulled: false, email: 'CoraEnglish@tamu.edu' },
  { groupname: 'Freshmen Are Cool', owner: 'Matthew Waterman',
    pulled: false, email: 'matthewwaterman@tamu.edu' }
]

# array of groups

#   more_groups = [
#     {:groupname => 'List Eaters', :members => ['Kareem Hirani', 'Baldwin Bakkal', 'Reid Neason', 'Jon Waterman']}

#   ]

more_groups.each do |group|
  Group.create!(group)
end

more_users = [
  { email: 'kareemh17@tamu.edu', first_name: 'Kareem', last_name: 'Hirani',
    password_digest: BCrypt::Password.create('Dummy'), pulled: false, group_id: 1,
    uin: 327001001, classification: 'U4', admin: false },
  { email: 'bbakkal97@tamu.edu', first_name: 'Baldwin', last_name: 'Bakkal',
    password_digest: BCrypt::Password.create('Dummy'), pulled: false, group_id: 1,
    uin: 327001002, classification: 'U4', admin: false },
  { email: 'jonrwaterman@tamu.edu', first_name: 'Jon', last_name: 'Waterman',
    password_digest: BCrypt::Password.create('Dummy'), pulled: false, group_id: 1,
    uin: 327001003, classification: 'U4', admin: false },
  { email: 'reidneason@tamu.edu', first_name: 'Reid', last_name: 'Neason',
    password_digest: BCrypt::Password.create('Dummy'), pulled: false, group_id: 1,
    uin: 327001004, classification: 'U4', admin: false },
  { email: 'CoraEnglish@tamu.edu', first_name: 'Cora', last_name: 'English',
    password_digest: BCrypt::Password.create('Dummy'), pulled: false, group_id: 2,
    uin: 327001005, classification: 'U4', admin: false },
  { email: 'GraceLi@tamu.edu', first_name: 'Grace', last_name: 'Li',
    password_digest: BCrypt::Password.create('Dummy'), pulled: false, group_id: 2,
    uin: 327001006, classification: 'U4', admin: false },
  { email: 'RebeccaMcfadden@tamu.edu', first_name: 'Rebecca', last_name: 'McFadden',
    password_digest: BCrypt::Password.create('Dummy'), pulled: false, group_id: 2,
    uin: 327001007, classification: 'U4', admin: false },
  { email: 'matthewwaterman@tamu.edu', first_name: 'Matthew', last_name: 'Waterman',
    password_digest: BCrypt::Password.create('Dummy'), pulled: false, group_id: 3,
    uin: 327001008, classification: 'U1', admin: false },
  { email: 'jaketraylor@tamu.edu', first_name: 'Jake', last_name: 'Traylor',
    password_digest: BCrypt::Password.create('Dummy'), pulled: false, group_id: 3,
    uin: 327001009, classification: 'U1', admin: false },
  { email: 'drritchey@tamu.edu', first_name: 'Philip', last_name: 'Ritchey',
    password_digest: BCrypt::Password.create('Dummy'), pulled: false, group_id: nil,
    uin: 1, classification: 'U5', admin: true }
]

more_users.each do |user|
  User.create!(user)
end

# require 'faker'

# 40.times do
#   seat = Seat.new
#   seat.seatnumber = Faker::Alphanumeric.alphanumeric(number: 2)
#   seat.assigned = Faker::Boolean.boolean(true_ratio: 0.2)
#   seat.save
# end
