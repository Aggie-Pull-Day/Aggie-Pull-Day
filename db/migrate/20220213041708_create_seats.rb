class CreateSeats < ActiveRecord::Migration[7.0]
  def change
    create_table :seats do |t|
      t.string :seatnumber
      t.boolean :assigned
      t.timestamps
    end
  end
end
