class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games, :id => false do |t|
      t.integer :id
      t.string :opponent
      t.timestamp :date

      t.timestamps
    end
  end
end
