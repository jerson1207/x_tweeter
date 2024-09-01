# spec/requests/reply_tweets_spec.rb

require 'rails_helper'

RSpec.describe "ReplyTweets", type: :request do
  let(:user) { create(:user) }
  let(:tweet) { create(:tweet, user: user) }
  let(:valid_attributes) { { tweet: { body: 'This is a reply' } } }

  before do
    sign_in user
  end

  describe "POST /reply_tweets" do
    context "with valid parameters" do
      it "creates a new reply tweet" do
        expect {
          post tweets_path, params: valid_attributes
        }.to change(Tweet, :count).by(1)

        expect(response).to redirect_to(dashboard_path)
      end
    end
  end
end
