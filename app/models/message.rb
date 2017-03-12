class Message < ApplicationRecord
  validates_presence_of :text
  belongs_to :chat_group
  belongs_to :user
  mount_uploader :image, ImageUploader
end
