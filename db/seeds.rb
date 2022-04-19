# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
more_games = [
  { hometeam: 'TAMU', opponent: 'Sam Houston State',
    gamedate: '3-Sep-2022', day: 'Saturday' },

  { hometeam: 'TAMU', opponent: 'App State',
    gamedate: '10-Sep-2022', day: 'Saturday' },

  { hometeam: 'TAMU', opponent: 'Miami (FL)',
    gamedate: '17-Sep-2022', day: 'Thursday' }
]

more_games.each do |game|
  Game.create!(game)
end

# works for single user

more_groups = [
  { groupname: 'List Eaters', owner: 'Kareem Hirani',
    pulled: false, email: 'Kareemh17@tamu.edu' },

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
  { email: 'kareemh17@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), pulled: false, group_id: 1,
    uin: 327001001, classification: 'U4' },
  { email: 'bbakkal97@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), pulled: false, group_id: 1,
    uin: 327001002, classification: 'U4' },
  { email: 'jonrwaterman@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), pulled: false, group_id: 1,
    uin: 327001003, classification: 'U4' },
  { email: 'reidneason@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), pulled: false, group_id: 1,
    uin: 327001004, classification: 'U4' },
  { email: 'CoraEnglish@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), pulled: false, group_id: 2,
    uin: 327001005, classification: 'U4' },
  { email: 'GraceLi@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), pulled: false, group_id: 2,
    uin: 327001006, classification: 'U4' },
  { email: 'RebeccaMcfadden@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), pulled: false, group_id: 2,
    uin: 327001007, classification: 'U4' },
  { email: 'matthewwaterman@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), pulled: false, group_id: 3,
    uin: 327001008, classification: 'U1' },
  { email: 'jaketraylor@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), pulled: false, group_id: 3,
    uin: 327001009, classification: 'U1' }
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
