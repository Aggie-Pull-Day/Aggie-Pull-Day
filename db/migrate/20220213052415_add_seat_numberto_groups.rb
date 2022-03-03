class AddSeatNumbertoGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :seatnumber, :string
  end
end
