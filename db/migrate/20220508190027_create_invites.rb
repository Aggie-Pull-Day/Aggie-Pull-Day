class CreateInvites < ActiveRecord::Migration[7.0]
  def change
    create_table :invites do |t|
      t.integer :group_id
      t.string :inviter
      t.string :invitee
      t.boolean :inviter_accepted
      t.boolean :invitee_accepted

      t.timestamps
    end
  end
end
