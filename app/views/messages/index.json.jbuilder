json.array! @chat_group.messages do |message|
  json.id         message.id
  json.text       message.text
  json.image      message.image
  json.created_at message.created_at

  json.user do
    json.name message.user.name
  end
end
