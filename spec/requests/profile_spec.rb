require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET /profiles" do
    it "renders the profile show template successfully" do
      get profile_path
      expect(response).to have_http_status(:success)
    end
  end
end
