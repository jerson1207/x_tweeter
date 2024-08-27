require 'rails_helper'

RSpec.describe "Tweets", type: :request do
  describe "GET /show" do
    it "success" do
      user = create(:user)
      sign_in user
      tweet = create(:tweet, user: user)
      get tweet_path(tweet)
      expect(response).to have_http_status(:success)        
    end
  end

  describe "POST /tweets" do
    context 'user is not signed in' do
      it "is respond with redirect" do
        post tweets_path, params: {
          tweet: {
            body: "new tweet body"
          }
        }
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'user is signed in' do
      it "create a new tweet" do
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
