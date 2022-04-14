class RemoveSeatNumberFromGroup < ActiveRecord::Migration[7.0]
  def change
    remove_column :groups, :seatnumber, :string
  end
end
