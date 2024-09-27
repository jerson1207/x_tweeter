require 'rails_helper'

RSpec.describe "Message Threads", type: :request do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:message_thread) { create(:message_thread) }

  before { sign_in user }
  
  describe "GET /messages" do
    it "succeeds and returns a successful response" do
      get message_threads_path
      expect(response).to have_http_status(:success)
    end

    context "when a new message thread needs to be created" do
      it "creates a new message thread if user_id is provided and not in thread" do
        expect {
          get message_threads_path, params: { user_id: other_user.id }
        }.to change(MessageThread, :count).by(1)

        new_thread = MessageThread.last

        expect(new_thread.users).to include(user, other_user)
      end

    end
  end
end