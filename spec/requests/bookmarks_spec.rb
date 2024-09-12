require 'rails_helper'

RSpec.describe "Bookmarks", type: :request do
  let(:user) { create(:user) }
  let(:tweet) { create(:tweet, user: user) }

  before { sign_in user }

  describe "GET /index" do
    it "returns a successful response and lists bookmarked tweets" do
      get bookmarks_path
      
      expect(response).to have_http_status(:success)
    end
  end

  describe "Post /tweets/:tweet_id/bookmarks" do
    it "creates a new bookmark" do
      expect do 
        post tweet_bookmarks_path(tweet)
      end.to change { Bookmark.count }.by(1)
      expect(response).to have_http_status(:redirect)
    end

  end

  describe "DELETE /tweets/:tweet_id/bookmark" do
    it "destroys an existing bookmark" do
      bookmark = create(:bookmark, user: user, tweet: tweet)
      expect do
        delete tweet_bookmark_path(tweet, bookmark)
      end.to change { Bookmark.count }.by(-1)
    end
  end
end
