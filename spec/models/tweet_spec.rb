require 'rails_helper'

RSpec.describe Tweet, type: :model do
  it { should belong_to :user }

  it { should have_many(:likes).dependent(:destroy)}
  it { should have_many(:liked_users).through(:likes).source(:user) }
  
  it { should have_many(:bookmarks).dependent(:destroy) }
  it { should have_many(:bookmarked_users).through(:bookmarks).source(:user) }

  it { should have_many(:retweets).dependent(:destroy) }
  it { should have_many(:retweeted_users).through(:retweets).source(:user) }

  it { should have_many(:views) }
  it { should have_many(:viewed_users).through(:views).source(:user) }

  it { should validate_presence_of(:body) }
  it { should validate_length_of(:body).is_at_most(1000) }

  it { should belong_to(:parent_tweet).with_foreign_key('parent_tweet_id').class_name('Tweet').inverse_of(:reply_tweets).optional }
  it { should have_many(:reply_tweets).with_foreign_key('parent_tweet_id').class_name('Tweet') }

  it { should have_and_belong_to_many :hashtags }

  describe '#parse_and_save_hashtags' do
    let(:user) { create(:user) }

    context 'when the tweet contains hashtags' do
      let(:tweet) { Tweet.new(user: user, body: "This is a #test tweet with multiple #hashtags") }

      it 'calls parse_and_save_hashtags and saves hashtags before save' do
        expect {
          tweet.save
        }.to change { Hashtag.count }.by(2) 
      end

      it 'creates hashtags for each unique hashtag in the body' do
        expect {
          tweet.save
        }.to change { Hashtag.count }.by(2)

        expect(Hashtag.pluck(:tag)).to include('test', 'hashtags')
      end
    end

    context 'when the tweet has no hashtags' do
      let(:body) { "This tweet has no hashtags" }
      let(:tweet) { Tweet.new(user: user, body: body) }

      it 'does not create any hashtags' do
        expect {
          tweet.save
        }.not_to change { Hashtag.count }
      end
    end

    context 'when the tweet has duplicate hashtags in the body' do
      let(:body) { "This is a #duplicate #duplicate tweet" }
      let(:tweet) { Tweet.new(user: user, body: body) }

      it 'creates the hashtag only once' do
        expect {
          tweet.save
        }.to change { Hashtag.count }.by(1)

        expect(Hashtag.where(tag: 'duplicate').count).to eq(1)
      end
    end

    context 'when a hashtag already exists' do
      let(:tweet) { Tweet.new(user: user, body: "This is a #test tweet with multiple #rails hashtags") }

      before do
        Hashtag.create(tag: 'test')
      end

      it 'does not create duplicate hashtags' do
        expect {
          tweet.save
        }.to change { Hashtag.count }.by(1)

        expect(Hashtag.where(tag: 'test').count).to eq(1)
        expect(Hashtag.where(tag: 'rails').count).to eq(1)
      end
    end
  end



end
