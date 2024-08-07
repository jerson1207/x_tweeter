require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /homes" do
    context "user is not signed in" do
      it "returns a successful response" do
        get root_path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'User is signed is' do
      it "redirects to the dashboard path" do
        user = create(:user)
        sign_in user
        get root_path
        expect(response).to redirect_to(dashboard_path)
      end
    end
  end
end
