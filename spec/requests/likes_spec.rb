require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let(:user) { create(:user) }
  let(:tweet) { create(:tweet, user: user) }

  before { sign_in user }

  describe "Post /tweets/:tweet_id/like" do
    it "creates a new like and  a notification" do
      expect do 
        post tweet_likes_path(tweet)
      end.to change { Like.count }.by(1).and change(Notification, :count).by(1)
      expect(response).to have_http_status(:redirect)
    end

  end

  describe "DELETE /tweets/:tweet_id/like" do
    it "destroys an existing like" do
      like = create(:like, user: user, tweet: tweet)
      expect do
        delete tweet_like_path(tweet, like)
      end.to change { Like.count }.by(-1)
    end
  end
end
