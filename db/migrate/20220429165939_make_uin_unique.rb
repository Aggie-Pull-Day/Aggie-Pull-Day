class MakeUinUnique < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :uin, :integer, unique: true
    change_column :students, :uin, :integer, unique: true
  end
end
