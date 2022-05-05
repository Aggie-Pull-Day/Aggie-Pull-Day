class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.integer :uin
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :classification

      t.timestamps
    end
  end
end
