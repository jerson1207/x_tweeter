require 'rails_helper'

RSpec.describe "Following", type: :request do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  before { sign_in user1 }

  describe 'POST #create' do
    it "create a new following" do
      expect do
        post user_followings_path(user1), params: {
          following_user_id: user2.id
        }
      end.to change { Following.count }.by(1)
      expect(response).to redirect_to user_path(user2)
    end
  end

  describe 'Delete #destroy' do
    it 'descroy the existing following' do
      following = create(:following, user: user1, following_user: user2)
      expect do
        delete user_following_path(user1, following)
      end.to change { Following.count }.by(-1)
      expect(response).to redirect_to user_path(user2)
    end
  end
end