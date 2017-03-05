FactoryGirl.define do
  factory :message do
    user_id       { Faker::Number.between(1, 100) }
    chat_group_id { Faker::Number.between(1, 100) }
    text          { Faker::Pokemon.name }
  end
end
