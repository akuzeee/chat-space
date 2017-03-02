class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string     :text
      t.references :user,       foreign_key: true, null: false
      t.references :chat_group, foreign_key: true, null: false
      t.timestamps
    end
  end
end
