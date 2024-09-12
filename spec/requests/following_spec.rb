require 'rails_helper'

RSpec.describe "Followings", type: :request do
  let(:current_user) { create(:user) }
  let(:other_user) { create(:user) }

  before do
    sign_in current_user  # Devise helper to authenticate current_user
  end

  describe "POST /users/:user_id/followings" do
    it "creates a new following" do
      expect do
        post user_followings_path(current_user), params: {
          following_user_id: other_user.id
        }
      end.to change(Following, :count).by(1)
      
      expect(response).to redirect_to(user_path(other_user))
    end
  end

  describe "DELETE /users/:user_id/followings/:id" do
    let!(:following) { current_user.followings.create(following_user_id: other_user.id) }

    it "destroys the following" do
      expect {
        delete user_following_path(current_user, following.id)
      }.to change(Following, :count).by(-1)
    
      expect(response).to redirect_to(user_path(current_user))
    end
  end
end
