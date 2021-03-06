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
  { uin: 327000001, pulled: false, group_id: 2, admin: false },
  { uin: 327000002, pulled: false, group_id: 1, admin: false },
  { uin: 327000003, pulled: false, group_id: 1, admin: false },
  { uin: 327000004, pulled: false, group_id: 1, admin: false },
  { uin: 327000005, pulled: false, group_id: 1, admin: false },
  { uin: 327000006, pulled: false, group_id: 1, admin: false },
  { uin: 327000007, pulled: false, group_id: 1, admin: false },
  { uin: 1, pulled: false, group_id: nil, admin: true },
  { uin: 827000000, pulled: false, group_id: 2, admin: false },
  { uin: 827000001, pulled: false, group_id: 2, admin: false },
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
emails = %w[kareemh17@tamu.edu jonrwaterman@tamu.edu reidneason@tamu.edu bbakkal97@tamu.edu rmcfadden@tamu.edu
            nikhitha06@tamu.edu gracenli@tamu.edu coraenglish@tamu.edu anukhatri@tamu.edu kchoudhury1@tamu.edu
            mahaliecs@tamu.edu derik0194@tamu.edu tonyy007@tamu.edu amosric@tamu.edu ojasonbernal@tamu.edu
            burgerman1020@tamu.edu nicbenavides@tamu.edu manuelraul5@tamu.edu cnewby5283@tamu.edu
            kvthiagarajan18@tamu.edu xavierp117@tamu.edu steveg251@tamu.edu wnorman136031@tamu.edu gaow051001@tamu.edu
            carolynnguyen@tamu.edu mrllpz@tamu.edu jyuan1999@tamu.edu emmaziesmer@tamu.edu ryanmparker@tamu.edu
            jirehferrer@tamu.edu sabrina@tamu.edu hyu@tamu.edu]
(0..names.length - 1).each do |i|
  Student.create!(uin: 327000000 + i, email: emails[i], password_digest: BCrypt::Password.create('Dummy'),
                  first_name: names[i][0], last_name: names[i][1], classification: 'U4')

end

Student.create!(uin: 827000000, email: 'matthewwaterman@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
                first_name: 'Matthew', last_name: 'Waterman', classification: 'U1')

Student.create!(uin: 827000001, email: 'ryansmith@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
                first_name: 'Ryan', last_name: 'Smith', classification: 'U1')

more_pull_times = [
  { weekday: 4, start_time: '8:00 AM', end_time: '5:00 PM' },
  { weekday: 3, start_time: '8:00 AM', end_time: '5:00 PM' },
  { weekday: 2, start_time: '8:00 AM', end_time: '5:00 PM' },
  { weekday: 1, start_time: '8:00 AM', end_time: '5:00 PM' },
  { weekday: 5, start_time: '8:00 AM', end_time: '5:00 PM' }
]

more_pull_times.each do |pt|
  PullTime.create!(pt)
end

# require 'faker'

# 40.times do
#   seat = Seat.new
#   seat.seatnumber = Faker::Alphanumeric.alphanumeric(number: 2)
#   seat.assigned = Faker::Boolean.boolean(true_ratio: 0.2)
#   seat.save
# end
