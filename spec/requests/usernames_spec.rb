require 'rails_helper'

RSpec.describe "Usernames", type: :request do
  let(:user) { create(:user, username: nil) }

  before { sign_in user }

  describe "GET /usernames/new" do  
    it "returns a successful response" do
      get new_username_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PUT /update" do
    context "when username is blank" do
      it "allows blank username and redirects to the dashboard" do
        put username_path(user), params: {
          user: { username: "" }  # Blank username
        }

        expect(user.reload.username).to be_blank  # Ensure username is still blank
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context "when updating to a unique username" do
      it "updates the username successfully" do
        expect {
          put username_path(user), params: {
            user: { username: "unique_username" }
          }
        }.to change { user.reload.username }.from(nil).to("unique_username")
        
        expect(response).to redirect_to(dashboard_path)
      end
    end    
  end
end
