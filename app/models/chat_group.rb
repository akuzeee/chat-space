class ChatGroup < ApplicationRecord
  validates_presence_of :name
  validates_acceptance_of :user_ids
  has_many :group_members
  has_many :users, through: :group_members
end
