FactoryBot.define do
  factory :user do
    email { "test@example.com" }
    password { "password123" }
    password_confirmation { "password123" } 
    username {"foobar"}
  end
end
