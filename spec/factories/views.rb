FactoryBot.define do
  factory :view do
    association :user
    association :tweet
  end
end
