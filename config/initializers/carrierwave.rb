require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['S3_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
    region: 'ap-northeast-1'
  }

  case Rails.env
    when 'production'
      config.fog_directory = 'chat-space-image-upload'
      config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/chat-space-image-upload'

    when 'development'
      config.fog_directory = 'chat-space-image-upload-development'
      config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/chat-space-image-upload-development'

    when 'test'
      config.fog_directory = 'chat-space-image-upload-test'
      config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/chat-space-image-upload-test'
  end
end
