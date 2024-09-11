FactoryBot.define do
  factory :following do
    association :user
    association :following_user
  end
end
