class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.belongs_to :group, foreign_key: true
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
