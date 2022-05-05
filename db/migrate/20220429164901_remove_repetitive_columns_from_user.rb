class RemoveRepetitiveColumnsFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :uin, :integer
    remove_column :users, :email, :string
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
    remove_column :users, :classification, :string
  end
end
