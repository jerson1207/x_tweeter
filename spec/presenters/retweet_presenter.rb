require 'rails_helper'

RSpec.describe RetweetPresenter, type: :presenter do
  let(:user) { create(:user) }
  let(:tweet) { create(:tweet, user: user) }
  let(:retweet) { create(:retweet, tweet: tweet, user: user) }
  let(:presenter) { described_class.new(tweet: tweet, current_user: user) }

  context 'when the tweet is retweeted by the current user' do
    before do
      create(:retweet, tweet: tweet, user: user)
    end

    it 'returns the correct URL for the retweeted tweet' do
      expect(presenter.url).to eq(tweet_retweet_path(tweet, user.retweets.find_by(tweet: tweet)))
    end

    it 'returns "delete" for request method' do
      expect(presenter.request).to eq("delete")
    end

    it 'returns the solid repeat icon HTML' do
      expect(presenter.retweet_icon).to include('<img src="/path/to/repeat-solid.svg"')
    end
  end

  context 'when the tweet is not retweeted by the current user' do
    it 'returns the correct URL for the unretweeted tweet' do
      expect(presenter.url).to eq(tweet_retweets_path(tweet))
    end

    it 'returns "post" for request method' do
      expect(presenter.request).to eq("post")
    end

    it 'returns the regular repeat icon HTML' do
      expect(presenter.retweet_icon).to include('<img src="/path/to/repeat.svg"')
    end
  end
end
