class RefactorSeatAssignment < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :seat_id, :integer
  end
end
