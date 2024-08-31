require 'rails_helper'

RSpec.describe ViewTweetJob, type: :job do
  let(:user) { create(:user) }
  let(:tweet) { create(:tweet, user: user) }

  describe "#perform" do
    context "when the tweet has not been viewed by the user" do
      it "creates a new View record" do
        expect {
          subject.perform(tweet.id, user.id)
        }.to change { View.count }.by(1)
      end
    end

    context "when the tweet has already been viewed by the user" do
      before do
        create(:view, tweet: tweet, user: user)
      end

      it "does not create a new View record" do
        expect {
          subject.perform(tweet.id, user.id)
        }.not_to change { View.count }
      end
    end
  end
end
