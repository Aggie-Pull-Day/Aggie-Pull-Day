class AddEmailToSeats < ActiveRecord::Migration[6.0]
  def change
    add_column :seats, :email, :string
  end
end
