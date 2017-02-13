class ChatGroup < ApplicationRecord
  has_many :users, through: :messages
end
