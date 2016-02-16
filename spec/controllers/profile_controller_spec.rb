require 'rails_helper'

RSpec.describe ProfileController, type: :controller do
  include SystemControllerSupport
  include Sorcery::TestHelpers::Rails::Integration
  include Sorcery::TestHelpers::Rails::Controller

  let!(:user) { create :user, :with_account }
  before(:each) do
    login_user user, login_url
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, id: 1
      expect(response.status).to eq 200
    end
  end

  describe 'PATCH #update' do
    it 'must redirect' do
      patch :update, user: { name: 123 }
      expect(response.status).to eq 302
    end
  end

  describe 'POST send_email_confirmation' do
    it 'must redirect' do
      allow(user).to receive(:deliver_email_confirmation!)
      post :send_email_confirmation
      expect(response.status).to eq 302
    end
  end

  describe 'GET #confirm_email' do
    let!(:user) { create :user, email: 'some@email.ru' }
    # before { user.send :require_email_confirmation }
    it 'must redirect' do
      expect_any_instance_of(User).to receive(:confirm_email!)
      get :confirm_email, token: user.email_confirm_token
      expect(response.status).to eq 302
    end
  end
end
