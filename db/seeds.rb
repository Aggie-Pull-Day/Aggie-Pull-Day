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
  { uin: 327001000, pulled: false, group_id: 2, admin: false },
  { uin: 327001001, pulled: false, group_id: 2, admin: false },
  { uin: 327001002, pulled: false, group_id: 2, admin: false },
  { uin: 327001003, pulled: false, group_id: 2, admin: false },
  { uin: 327001004, pulled: false, group_id: 1, admin: false },
  { uin: 327001005, pulled: false, group_id: 1, admin: false },
  { uin: 327001006, pulled: false, group_id: 1, admin: false },
  { uin: 327001007, pulled: false, group_id: 1, admin: false },
  { uin: 1, pulled: false, group_id: nil, admin: true }
]

more_users.each do |user|
  User.create!(user)
end

Student.create!(uin: 1, email: 'drritchey@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
                first_name: 'Philip', last_name: 'Ritchey', classification: 'U5')
names = [%w[Rebecca McFadden], %w[Nikitha Vempati], %w[Grace Li], %w[Cora English], %w[Kareem Hirani],
         %w[Jon Waterman], %w[Reid Neason], %w[Baldwin Bakkal], %w[Anu Khatri], %w[Keegan Choudhury], %w[Hallie Scasta],
         %w[Derik Wang], %w[Tony Yang], %w[Osric Nagle], %w[Jason Bernal], %w[Jacob Smith], %w[Nicolas Benavides],
         %w[Manuel Trevino], %w[Cole Newby], %w[Kavi Thiagarajan], %w[Xavier Polisetty], %w[Steve George],
         %w[Will Norman], %w[Wei-Jie Gao], %w[Carolyn Nguyen], %w[Mari Lopez], %w[Jennifer Yuan], %w[Emma Ziesmer],
         %w[Ryan Parker], %w[Jireh Ferrer], %w[Sabrina Smith], %w[Hanson Yu]]
(0..names.length - 1).each do |i|
  email = case i
          when 4
            'kareemh17@tamu.edu'
          when 5
            'jonrwaterman@tamu.edu'
          when 6
            'reidneason@tamu.edu'
          when 7
            'bbakkal97@tamu.edu'
          else
            "#{names[i][0]}#{names[i][1]}@tamu.edu"
          end
  Student.create!(uin: 327000000 + i, email: email, password_digest: BCrypt::Password.create('Dummy'),
                  first_name: names[i][0], last_name: names[i][1], classification: 'U4')
end

# require 'faker'

# 40.times do
#   seat = Seat.new
#   seat.seatnumber = Faker::Alphanumeric.alphanumeric(number: 2)
#   seat.assigned = Faker::Boolean.boolean(true_ratio: 0.2)
#   seat.save
# end
