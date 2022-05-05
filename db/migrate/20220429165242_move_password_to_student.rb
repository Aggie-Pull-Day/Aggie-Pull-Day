class MovePasswordToStudent < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :password_digest, :string
    add_column :students, :password_digest, :string
  end
end
