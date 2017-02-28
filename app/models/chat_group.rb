class ChatGroup < ApplicationRecord
  validates_presence_of :name
  has_many :group_members
  has_many :users, through: :group_members
  has_many :messages, ->{ order(created_at: :asc) }
end
