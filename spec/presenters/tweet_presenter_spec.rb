require 'rails_helper'

RSpec.describe TweetPresenter, type: :presenter do
  describe "#created_at" do
    context "when more than 24 hours have passed" do
      before do
        travel_to Time.local(2023, 8, 18, 10, 0, 0)
      end

      after do
        travel_back
      end
      it "displays the short date format" do
        tweet = create(:tweet)
        tweet.update! created_at: 2.days.ago

        presenter = TweetPresenter.new(tweet: tweet, current_user: build_stubbed(:user))
        expect(presenter.formatted_created_at).to eq('Aug 16')
      end
    end

    context "when less than 24 hours have passed" do
      it "displays the time ago format" do
        tweet = create(:tweet)
        tweet.update! created_at: 2.hours.ago
        presenter = TweetPresenter.new(tweet: tweet, current_user: build_stubbed(:user))
        expect(presenter.formatted_created_at).to eq('about 2 hours ago')
      end
    end
  end
end