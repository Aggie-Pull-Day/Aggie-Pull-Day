class RemoveHometeamAndDayFromGames < ActiveRecord::Migration[7.0]
  def change
    remove_column :games, :hometeam, :string
    remove_column :games, :day, :string
  end
end
