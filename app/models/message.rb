class Message < ApplicationRecord
  validates_presence_of :text
  belongs_to :chat_group
  belongs_to :user

  def to_builder
    Jbuilder.new do |message|
      message.text       text
      message.created_at created_at
      message.user_name  user.name
    end
  end
end
