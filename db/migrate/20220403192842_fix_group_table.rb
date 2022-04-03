class FixGroupTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :groups, :member
    remove_column :groups, :email
    add_column :groups, :game_id, :integer
  end
end
