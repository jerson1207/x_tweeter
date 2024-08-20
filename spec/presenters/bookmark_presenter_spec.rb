require 'rails_helper'

RSpec.describe BookmarkPresenter, type: :presenter do
  let(:user) { create(:user) }
  let(:tweet) { create(:tweet, user: user) }
  let(:bookmark) { create(:bookmark, tweet: tweet, user: user) }
  let(:presenter) { described_class.new(tweet: tweet, current_user: user) }

  context 'when the tweet is bookmarked by the current user' do
    before do
      create(:bookmark, tweet: tweet, user: user)
    end

    it 'returns the correct URL for the bookmarked tweet' do
      expect(presenter.url).to eq(tweet_bookmark_path(tweet, user.bookmarks.find_by(tweet: tweet)))
    end

    it 'returns "delete" for request method' do
      expect(presenter.request).to eq("delete")
    end

    it 'returns the solid bookmark icon HTML' do
      expect(presenter.bookmark_icon).to include('<i class="fa-solid fa-bookmark"></i>')
    end
  end

  context 'when the tweet is not bookmarked by the current user' do
    it 'returns the correct URL for the unbookmarked tweet' do
      expect(presenter.url).to eq(tweet_bookmarks_path(tweet))
    end

    it 'returns "post" for request method' do
      expect(presenter.request).to eq("post")
    end

    it 'returns the regular bookmark icon HTML' do
      expect(presenter.bookmark_icon).to include('<i class="fa-regular fa-bookmark"></i>')
    end
  end
end
