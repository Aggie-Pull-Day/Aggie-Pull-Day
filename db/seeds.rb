# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
more_games = [
  { opponent: 'Sam Houston State', gamedate: '3-Sep-2022' },
  { opponent: 'App State', gamedate: '10-Sep-2022' },
  { opponent: 'Miami (FL)', gamedate: '17-Sep-2022' }
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
  { uin: 327001001, pulled: false, group_id: 1, admin: false },
  { uin: 327001002, pulled: false, group_id: 1, admin: false },
  { uin: 327001003, pulled: false, group_id: 1, admin: false },
  { uin: 327001004, pulled: false, group_id: 1, admin: false },
  { uin: 327001005, pulled: false, group_id: 2, admin: false },
  { uin: 327001006, pulled: false, group_id: 2, admin: false },
  { uin: 327001007, pulled: false, group_id: 2, admin: false },
  { uin: 327001008, pulled: false, group_id: 3, admin: false },
  { uin: 327001009, pulled: false, group_id: 3, admin: false },
  { uin: 1, pulled: false, group_id: nil, admin: true }
]

more_users.each do |user|
  User.create!(user)
end

more_students = [
  { uin: 327001001, email: 'kareemh17@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
    first_name: 'Kareem', last_name: 'Hirani', classification: 'U4' },
  { uin: 327001002, email: 'bbakkal97@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
    first_name: 'Baldwin', last_name: 'Bakkal', classification: 'U4' },
  { uin: 327001003, email: 'jonrwaterman@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
    first_name: 'Jon', last_name: 'Waterman', classification: 'U4' },
  { uin: 327001004, email: 'reidneason@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
    first_name: 'Reid', last_name: 'Neason', classification: 'U4' },
  { uin: 327001005, email: 'CoraEnglish@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
    first_name: 'Cora', last_name: 'English', classification: 'U4' },
  { uin: 327001006, email: 'GraceLi@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), first_name: 'Grace',
    last_name: 'Li', classification: 'U4' },
  { uin: 327001007, email: 'RebeccaMcfadden@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
    first_name: 'Rebecca', last_name: 'McFadden', classification: 'U4' },
  { uin: 327001008, email: 'matthewwaterman@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
    first_name: 'Matthew', last_name: 'Waterman', classification: 'U1' },
  { uin: 327001009, email: 'jaketraylor@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
    first_name: 'Jake', last_name: 'Traylor', classification: 'U1' },
  { uin: 1, email: 'drritchey@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
    first_name: 'Philip', last_name: 'Ritchey', classification: 'U5' }
]

more_students.each do |student|
  Student.create!(student)
end

# require 'faker'

# 40.times do
#   seat = Seat.new
#   seat.seatnumber = Faker::Alphanumeric.alphanumeric(number: 2)
#   seat.assigned = Faker::Boolean.boolean(true_ratio: 0.2)
#   seat.save
# end
