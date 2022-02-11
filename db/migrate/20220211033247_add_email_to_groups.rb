class AddEmailToGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :email, :string
  end
end
