require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:tweets).dependent(:destroy) }

  it { should have_many(:likes).dependent(:destroy) }
  it { should have_many(:liked_tweets).through(:likes).source(:tweet) }
  
  it { should have_many(:bookmarks).dependent(:destroy) }
  it { should have_many(:bookmarked_tweets).through(:bookmarks).source(:tweet) }

  it { should have_many(:retweets).dependent(:destroy) }
  it { should have_many(:retweeted_tweets).through(:retweets).source(:tweet) }

  it { should validate_uniqueness_of(:username).case_insensitive }

  describe "#set_display_name" do
    context "when display_name is set" do
      it "does not change the display name" do
        user = build(:user, username: "james", display_name: "James Harded")
        user.save
        expect(user.reload.display_name).to eq("James Harded")
      end
    end

    context "when display_name is  not set" do
      it "humanize the previously set name" do
        user = build(:user, username: "james", display_name: nil)
        user.save
        expect(user.reload.display_name).to eq("James")
      end
    end
  end

  describe '#resize_avatar' do
    let(:user) { create(:user) }

    context 'when avatar is attached' do
      before do
        # Attach an avatar to the user
        user.avatar.attach(io: File.open('spec/fixtures/files/profile_sample.png'), filename: 'profile_sample.png', content_type: 'image/png')
      end

      it 'checks if the avatar is attached' do
        expect(user.avatar).to be_attached
      end
    end
  end

end
