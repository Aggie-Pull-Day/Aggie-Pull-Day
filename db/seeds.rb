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
      :pulled => false},
      {:groupname => 'List Eaters', :member => 'Baldwin Bakkal',
        :pulled => false},
        {:groupname => 'List Eaters', :member => 'Reid Neason',
            :pulled => false},
            {:groupname => 'List Eaters', :member => 'Jon Waterman',
                :pulled => false}
  ]

#array of groups

#   more_groups = [
#     {:groupname => 'List Eaters', :members => ['Kareem Hirani', 'Baldwin Bakkal', 'Reid Neason', 'Jon Waterman']}

#   ]

  more_groups.each do |group|
    Group.create!(group)
  end