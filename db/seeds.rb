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
  
  more_games.each do |game|
    Game.create!(game)
  end


#works for single user

  more_groups = [
    {:groupname => 'List Eaters', :member => 'Kareem Hirani',
      :pulled => false, :email => 'KareemH@tamu.edu'},
      {:groupname => 'List Eaters', :member => 'Baldwin Bakkal',
        :pulled => false, :email => 'BaldwinB@tamu.edu'},
        {:groupname => 'List Eaters', :member => 'Reid Neason',
            :pulled => false, :email => 'ReidN@tamu.edu'},
            {:groupname => 'List Eaters', :member => 'Jon Waterman',
                :pulled => false, :email => 'JonW@tamu.edu'},
                {:groupname => 'Team 1', :member => 'Cora English',
                  :pulled => false, :email => 'CoraE@tamu.edu'},
                  {:groupname => 'Team 1', :member => 'Grace Li',
                    :pulled => false, :email => 'GraceL@tamu.edu'},
                    {:groupname => 'Team 1', :member => 'Rebecca McFadden',
                      :pulled => false, :email => 'RebeccaF@tamu.edu'},
                      {:groupname => 'Team 1', :member => 'Nikhita Vehmpati',
                        :pulled => false, :email => 'NikhitaV@tamu.edu'}
  ]

#array of groups

#   more_groups = [
#     {:groupname => 'List Eaters', :members => ['Kareem Hirani', 'Baldwin Bakkal', 'Reid Neason', 'Jon Waterman']}

#   ]

  more_groups.each do |group|
    Group.create!(group)
  end



more_users = [

  {:email => "KareemH@tamu.edu", :password_digest => "Dummy"},
  {:email => "BaldwinB@tamu.edu", :password_digest => "Dummy"},
  {:email => "ReidN@tamu.edu", :password_digest => "Dummy"},
  {:email => "JonW@tamu.edu", :password_digest => "Dummy"},
  {:email => "CoraE@tamu.edu", :password_digest => "Dummy"},
  {:email => "GraceL@tamu.edu", :password_digest => "Dummy"},
  {:email => "RebeccaF@tamu.edu", :password_digest => "Dummy"},
  {:email => "NikhitaV@tamu.edu", :password_digest => "Dummy"}

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