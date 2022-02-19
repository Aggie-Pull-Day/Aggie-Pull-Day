class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :hometeam
      t.string :opponent
      t.datetime :gamedate
      t.string :day

      t.timestamps
    end
  end
end
