class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.string :uin
      t.string :seat_assignment

      t.timestamps
    end
  end
end
