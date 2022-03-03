class FixColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :password_giest, :password_digest
  end
end
