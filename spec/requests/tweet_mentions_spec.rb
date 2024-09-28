require 'rails_helper'

RSpec.describe "Tweet Mentions", type: :request do
  let!(:actor) { create(:user) }
  let!(:mentioned_user) { create(:user, username: "mentioned_user") }
  let(:tweet_body_with_mention) { "@mentioned_user Check this out!" }
  let(:tweet_body_without_mention) { "@mentioned_no_user Check this out!" }

  before do
    sign_in actor
    allow(ViewTweetJob).to receive(:perform_async)
  end

  describe "POST /tweets" do
    context 'with valid mention_user' do
      it "creates a tweet and generates a mention notification" do
        expect {
          post tweets_path, params: {
            tweet: { body: tweet_body_with_mention }
          }
        }.to change(Tweet, :count).by(1)
         .and change(Notification, :count).by(1)
      end
    end

    context 'with invalid mention_user' do
      it "creates a tweet and does not generate a mention notification" do
        expect {
          post tweets_path, params: {
            tweet: { body: tweet_body_without_mention }
          }
        }.to change(Tweet, :count).by(1)
         .and change(Notification, :count).by(0)
      end
    end
  end
end
