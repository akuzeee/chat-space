json.(@message, :text, :image, :created_at)

json.user do
  json.name current_user.name
end
