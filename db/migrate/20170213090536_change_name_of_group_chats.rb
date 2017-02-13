class ChangeNameOfGroupChats < ActiveRecord::Migration[5.0]
  def self.up
    change_column_null :chat_groups, :name, false
  end

  def self.down
    change_column_null :chat_groups, :name, true
  end
end
