class CreateChatGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_groups do |t|
      t.string     :name
      t.timestamps null: false
    end
  end
end
