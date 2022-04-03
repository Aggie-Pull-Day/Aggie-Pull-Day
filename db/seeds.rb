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

more_groups = [{ groupname: 'List Eaters', pulled: false, game_id: 1 },
               { groupname: 'Team 1', pulled: false, game_id: 1 }]

# array of groups

#   more_groups = [
#     {:groupname => 'List Eaters', :members => ['Kareem Hirani', 'Baldwin Bakkal', 'Reid Neason', 'Jon Waterman']}

#   ]

more_groups.each do |group|
  Group.create!(group)
end

more_users = [

  { email: 'KareemH@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), classification: 'U4', group_id: 1 },
  { email: 'BaldwinB@tamu.edu', password_digest: 'Dummy', classification: 'U4', group_id: 1 },
  { email: 'ReidN@tamu.edu', password_digest: 'Dummy', classification: 'U4', group_id: 1 },
  { email: 'JonW@tamu.edu', password_digest: 'Dummy', classification: 'U4', group_id: 1 },
  { email: 'CoraE@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), classification: 'U4', group_id: 2 },
  { email: 'GraceL@tamu.edu', password_digest: 'Dummy', classification: 'U4', group_id: 2 },
  { email: 'RebeccaF@tamu.edu', password_digest: 'Dummy', classification: 'U4', group_id: 2 },
  { email: 'NikhitaV@tamu.edu', password_digest: 'Dummy', classification: 'U4', group_id: 2 }

]

more_users.each do |user|
  User.create!(user)
end

require 'faker'

40.times do
  seat = Seat.new
  seat.seatnumber = Faker::Alphanumeric.alphanumeric(number: 2)
  seat.assigned = Faker::Boolean.boolean(true_ratio: 0.2)
  seat.save
end
