class CreateGroupMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :group_members do |t|
      t.references :user,       foreign_key: true, null: false
      t.references :chat_group, foreign_key: true, null: false
      t.timestamps              null: false
    end
  end
end
