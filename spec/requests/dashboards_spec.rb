require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  describe "GET /dashboards" do
    context "when user is not signed in" do
      it "redirects to the sign-in page" do
        get dashboard_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is signed in" do
      it "returns a successful response" do
        user = create(:user)
        sign_in user
        get dashboard_path
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
