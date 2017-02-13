class Message < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  belongs_to :chat_group
end
