class ReplaceMemberwithOwner < ActiveRecord::Migration[7.0]
  def change
    rename_column :groups, :member, :owner
  end
end
