require 'rails_helper'

RSpec.describe "Tweets", type: :request do
  describe "GET /show" do
    let(:user) { create(:user) }
    let(:tweet) { create(:tweet, user: user) }

    before do
      sign_in user
      # Corrected the stubbing to expect the right arguments
      allow(ViewTweetJob).to receive(:perform_async)
    end

    it "success" do
      get tweet_path(tweet)
      expect(response).to have_http_status(:success)
    end

    it "queues up ViewTweetJob" do
      get tweet_path(tweet)
      # Corrected to expect the actual arguments
      expect(ViewTweetJob).to have_received(:perform_async).with(tweet.id, user.id)
    end
  end

  describe "POST /tweets" do
    context 'user is not signed in' do
      it "responds with redirect" do
        post tweets_path, params: {
          tweet: {
            body: "new tweet body"
          }
        }
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'user is signed in' do
      it "creates a new tweet" do
        user = create(:user)
        sign_in user
        expect do
          post tweets_path, params: {
            tweet: {
              body: "new tweet body"
            }
          }
        end.to change { Tweet.count }.by(1)
        expect(response).to redirect_to(dashboard_path)
      end
    end
  end
end
