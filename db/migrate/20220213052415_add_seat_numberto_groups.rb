class AddSeatNumbertoGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :seatnumber, :string
  end
end
