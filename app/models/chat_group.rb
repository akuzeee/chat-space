class ChatGroup < ApplicationRecord
  validates_presence_of :name
  has_many :group_members
  has_many :users, through: :group_members
  accepts_nested_attributes_for :group_members
end
