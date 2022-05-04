class AddCodeToGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :code, :string
  end
end
