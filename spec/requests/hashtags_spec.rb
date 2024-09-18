require 'rails_helper'

RSpec.describe "Hashtags", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET /explorer" do
    it "returns a successful response" do
      get hashtags_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /explore/:id" do
    it "returns a successful response" do
      tweet = create(:tweet, user: user, body: "This is a #test tweet with multiple #hashtags")
      hashtag = Hashtag.find_by(tag: "test")
      get hashtag_path(hashtag)
      expect(response).to have_http_status(:success)
    end
  end
end
