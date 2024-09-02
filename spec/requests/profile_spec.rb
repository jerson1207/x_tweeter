require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) do
    {
      username: 'new_username',
      display_name: 'New Display Name',
      email: 'new_email@example.com',
      password: 'newpassword',
      location: 'New Location',
      bio: 'New Bio',
      url: 'http://newurl.com'
    }
  end

  before { sign_in user }

  describe "GET /profiles" do
    it "renders the profile show template successfully" do
      get profile_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      it 'updates the user and redirects to profile_path' do
        expect do
          put profile_path, params: {
            user: {
              bio: "new profile"
            }
          }
        end.to change { user.reload.bio}.from(nil).to("new profile")
        expect(response).to redirect_to(profile_path)
      end

      it 'responds with turbo stream format' do
        put profile_path, params: {
          user: {
            bio: "new profile"
          }
        }, as: :turbo_stream
        expect(response.content_type).to include('text/vnd.turbo-stream.html')
      end
    end
  end
end
