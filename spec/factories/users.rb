FactoryGirl.define do
  factory :user do
    name                  { Faker::Name.name}
    email                 { Faker::Internet.email }
    password              "aaaaaaaa"
    password_confirmation "aaaaaaaa"
  end
end
