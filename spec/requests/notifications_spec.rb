require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET /index" do
    it "succeeds" do
      get notifications_path
      expect(response).to have_http_status(:success)
    end

  end
end