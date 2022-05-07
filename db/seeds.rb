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
    pulled: false, email: 'kareemh17@tamu.edu', code: '111' },
  { groupname: 'Team 1', owner: 'Cora English',
    pulled: false, email: 'CoraEnglish@tamu.edu', code: '112' },
  { groupname: 'Freshmen Are Cool', owner: 'Matthew Waterman',
    pulled: false, email: 'matthewwaterman@tamu.edu', code: '113' }
]

# array of groups

#   more_groups = [
#     {:groupname => 'List Eaters', :members => ['Kareem Hirani', 'Baldwin Bakkal', 'Reid Neason', 'Jon Waterman']}

#   ]

more_groups.each do |group|
  Group.create!(group)
end

more_users = [
  { uin: 327000000, pulled: false, group_id: 1, admin: false },
  { uin: 327000001, pulled: false, group_id: 1, admin: false },
  { uin: 327000002, pulled: false, group_id: 1, admin: false },
  { uin: 327000003, pulled: false, group_id: 1, admin: false },
  { uin: 327000004, pulled: false, group_id: 2, admin: false },
  { uin: 327000005, pulled: false, group_id: 2, admin: false },
  { uin: 327000006, pulled: false, group_id: 2, admin: false },
  { uin: 327000007, pulled: false, group_id: 2, admin: false },
  { uin: 1, pulled: false, group_id: nil, admin: true }
]

more_users.each do |user|
  User.create!(user)
end

Student.create!(uin: 1, email: 'drritchey@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
                first_name: 'Philip', last_name: 'Ritchey', classification: 'U5')
names = [%w[Kareem Hirani], %w[Jon Waterman], %w[Reid Neason], %w[Baldwin Bakkal], %w[Rebecca McFadden],
         %w[Nikitha Vempati], %w[Grace Li], %w[Cora English], %w[Anu Khatri], %w[Keegan Choudhury], %w[Hallie Scasta],
         %w[Derik Wang], %w[Tony Yang], %w[Osric Nagle], %w[Jason Bernal], %w[Jacob Smith], %w[Nicolas Benavides],
         %w[Manuel Trevino], %w[Cole Newby], %w[Kavi Thiagarajan], %w[Xavier Polisetty], %w[Steve George],
         %w[Will Norman], %w[Wei-Jie Gao], %w[Carolyn Nguyen], %w[Mari Lopez], %w[Jennifer Yuan], %w[Emma Ziesmer],
         %w[Ryan Parker], %w[Jireh Ferrer], %w[Sabrina Smith], %w[Hanson Yu]]
(0..names.length - 1).each do |i|
  email = case i
          when 0
            'kareemh17@tamu.edu'
          when 1
            'jonrwaterman@tamu.edu'
          when 2
            'reidneason@tamu.edu'
          when 3
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
