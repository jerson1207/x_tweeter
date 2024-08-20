require 'rails_helper'

RSpec.describe LikePresenter, type: :presenter do
  let(:user) { create(:user) }
  let(:tweet) { create(:tweet, user: user) }
  let(:like) { create(:like, tweet: tweet, user: user) }
  let(:presenter) { described_class.new(tweet: tweet, current_user: user) }

  context 'when the tweet is liked by the current user' do
    before do
      create(:like, tweet: tweet, user: user)
    end

    it 'returns the correct URL for the liked tweet' do
      expect(presenter.url).to eq(tweet_like_path(tweet, user.likes.find_by(tweet: tweet)))
    end

    it 'returns "delete" for request method' do
      expect(presenter.request).to eq("delete")
    end

    it 'returns the solid heart icon HTML' do
      expect(presenter.heart_icon).to include('<i class="fa-solid fa-heart"></i>')
    end
  end

  context 'when the tweet is not liked by the current user' do
    it 'returns the correct URL for the unliked tweet' do
      expect(presenter.url).to eq(tweet_likes_path(tweet))
    end

    it 'returns "post" for request method' do
      expect(presenter.request).to eq("post")
    end

    it 'returns the regular heart icon HTML' do
      expect(presenter.heart_icon).to include('<i class="fa-regular fa-heart"></i>')
    end
  end
end
