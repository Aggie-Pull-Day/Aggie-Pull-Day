class AddClassificationToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :classification, :string
  end
end
