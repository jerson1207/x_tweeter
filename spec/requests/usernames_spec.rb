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
    context 'with valid params including image attachment' do  
    let(:image_file) { fixture_file_upload('spec/fixtures/files/profile_sample.png', 'image/png') }

      it "update the username" do
        expect do
          put username_path(user), params: {
            user: {
              username: "foobar",
              avatar: image_file
            }
          }
        end.to change { user.reload.username }.from(nil).to("foobar").and change { user.avatar.attached? }.from(false).to(true)
        
        user.reload
        expect(user.display_name).to eq("Foobar")
        expect(response).to redirect_to(dashboard_path)
        expect(user.avatar).to be_attached
        expect(user.avatar.filename.to_s).to eq('profile_sample.png')
      end
    end

    context 'with invalid params' do
      it "did not update the username" do
        expect do
          put username_path(user), params: {
            user: {
              username: ""
            }
          }
        end.not_to change { user.reload.username }
        expect(response).to redirect_to(new_username_path)
      end
    end
  end
end
