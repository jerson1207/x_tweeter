require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  before { sign_in user }

  describe 'GET /users/:id' do
    context 'when accessing own profile' do
      it 'redirects to the profile path' do
        get user_path(user)
        expect(response).to redirect_to(profile_path)
      end
    end

    context 'when accessing another user\'s profile' do
      it 'renders the show template' do
        get user_path(other_user)
        expect(response).to have_http_status(:success)
      end
    end
  end
end
