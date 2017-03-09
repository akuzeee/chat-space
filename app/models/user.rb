class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :name
  has_many :group_members
  has_many :chat_groups, ->{ order(created_at: :desc) }, through: :group_members
  has_many :messages

  scope :search_by_name, -> name { where('name LIKE(?)', name + '%') }

  def join_in?(chat_group)
    chat_groups.include?(chat_group)
  end
end
