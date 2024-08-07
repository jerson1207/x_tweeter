require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user_with_email = create(:user, email: "unique@example.com")
  end

  it {should have_many(:tweets).dependent(:destroy)}
  it { should validate_uniqueness_of(:username).case_insensitive }
  
  it "allows username to be blank" do
    user_with_blank_username = build(:user, email: "another@example.com", username: nil)
    expect(user_with_blank_username).to be_valid
  end

  it "does not allow duplicate usernames" do
    user1 = create(:user, username: 'unique_username')
    user2 = build(:user, username: 'unique_username')
    expect(user2).not_to be_valid
    expect(user2.errors[:username]).to include('has already been taken')
  end
end
