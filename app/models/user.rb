class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :name
  has_many :group_members
  has_many :chat_groups, through: :group_members
  has_many :messages

  def join_in?(chat_group)
    chat_groups.include?(chat_group)
  end
end
