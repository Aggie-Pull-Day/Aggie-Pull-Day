class AddEmailToSeats < ActiveRecord::Migration[7.0]
  def change
    add_column :seats, :email, :string
  end
end
