FactoryBot.define do
  factory :message_thread do
    after(:create) do |message_thread|
      user = create(:user)
      other_user = create(:user)

      message_thread.users << user
      message_thread.users << other_user
    end
  end
end
