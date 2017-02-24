class ChatGroup < ApplicationRecord
  validates_presence_of :name
  has_many :group_members
  has_many :users, through: :group_members
  accepts_nested_attributes_for :group_members, reject_if: :group_member_already_exists

  private
  def group_member_already_exists(attributed)
    GroupMember.where('user_id = ? and chat_group_id = ?', attributed[:user_id], id).any?
  end
end
