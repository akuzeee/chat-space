FactoryGirl.define do
  factory :message do
    user
    chat_group
    text          { Faker::Pokemon.name }
  end
end
