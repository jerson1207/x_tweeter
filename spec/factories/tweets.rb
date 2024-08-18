FactoryBot.define do
  factory :tweet do
    association :user
    body { "MyText" }
  end
end
