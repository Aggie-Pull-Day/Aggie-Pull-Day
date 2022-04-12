# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
more_games = [
    {:hometeam => 'TAMU', :opponent => 'Sam Houston State',
      :gamedate => '3-Sep-2022', :day => 'Saturday'},


      {:hometeam => 'TAMU', :opponent => 'App State',
        :gamedate => '10-Sep-2022', :day => 'Saturday'},


        {:hometeam => 'TAMU', :opponent => 'Miami (FL)',
            :gamedate => '17-Sep-2022', :day => 'Thursday'}
  ]
  
  # more_games.each do |game|
  #   Game.create!(game)
  # end


#works for single user

  more_groups = [
    {:groupname => 'List Eaters', :owner => 'Kareem Hirani',
      :pulled => false, :email => 'Kareemh17@tamu.edu'},

    {:groupname => 'Team 1', :owner => 'Cora English',
      :pulled => false, :email => 'CoraEnglish@tamu.edu'}
  ]

#array of groups

#   more_groups = [
#     {:groupname => 'List Eaters', :members => ['Kareem Hirani', 'Baldwin Bakkal', 'Reid Neason', 'Jon Waterman']}

#   ]

more_groups.each do |group|
   Group.create!(group)
end



more_users = [

  {:email => "Kareemh17@tamu.edu", :password_digest => BCrypt::Password.create("Dummy"),:pulled => false, :group_id => 1, :uin => 327001014},
  {:email => "BBakkal@tamu.edu", :password_digest => BCrypt::Password.create("Dummy"),:pulled => false, :group_id => 1, :uin => 327001015},  # {:email => "ReidN@tamu.edu", :password_digest => "Dummy"},
  {:email => "JonWaterman@tamu.edu", :password_digest => BCrypt::Password.create("Dummy"),:pulled => false, :group_id => 1, :uin => 327001016},  # {:email => "ReidN@tamu.edu", :password_digest => "Dummy"},
  
  
  {:email => "CoraEnglish@tamu.edu", :password_digest => BCrypt::Password.create("Dummy"),:pulled => false, :group_id => 2, :uin => 327001017},
  {:email => "GraceLi@tamu.edu", :password_digest => BCrypt::Password.create("Dummy"),:pulled => false, :group_id => 2, :uin => 327001018},  # {:email => "ReidN@tamu.edu", :password_digest => "Dummy"},
  {:email => "RebeccaMcfadden@tamu.edu", :password_digest => BCrypt::Password.create("Dummy"),:pulled => false, :group_id => 2, :uin => 327001019}  # {:email => "ReidN@tamu.edu", :password_digest => "Dummy"},
 
  # {:email => "NikhitaV@tamu.edu", :password_digest => "Dummy"}

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