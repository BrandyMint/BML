require 'rails_helper'

describe SessionsController do
  include Sorcery::TestHelpers::Rails::Integration
  include Sorcery::TestHelpers::Rails::Controller

  let(:password) { 123 }
  let!(:user) { create :user, :with_account, password: password }
  before do
    login_user user, login_url
  end

  describe 'GET #new' do
    it 'must return success' do
      get :new
      expect(response.status).to eq 200
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      context 'by email' do
        it 'must log in' do
          post :create, session_form: { login: user.email, password: password }
          expect(controller.current_user).to be_an_instance_of(User)
          expect(response.status).to eq 302
          expect(response.redirect_url).to eq account_root_url
        end
      end

      context 'by phone' do
        it 'must log in' do
          post :create, session_form: { login: user.phone, password: password }
          expect(controller.current_user).to be_an_instance_of(User)
          expect(response.status).to eq 302
          expect(response.redirect_url).to eq account_root_url
        end
      end
    end

    context 'with invalid params' do
      it 'must not log in' do
        request.env['HTTP_REFERER'] = 'some'
        get :create, session_form: { login: 'a' }
        expect(controller.current_user).not_to be_an_instance_of(User)
      end
    end

    context 'invite' do
      let!(:invite) { create :invite }
      let(:account) { invite.account }
      let(:form) { { login: user.email, password: password } }
      context 'background' do
        it 'must not be a member of account' do
          expect(account.users).to_not include user
        end
      end

      it 'must bind user to account' do
        post :create, session_form: form, invite_key: invite.key

        expect(controller.current_user).to be_an_instance_of(User)
        expect(response.status).to eq 302
        expect(response.redirect_url).to eq account_root_url
        expect(account.users).to include user
      end
    end

    context 'phone confirmation' do
      let(:form) { { login: user.phone, password: password } }
      it 'must confirm phone' do
        expect_any_instance_of(User).to receive(:confirm_phone!)
        post :create, session_form: form

        expect(controller.current_user).to be_an_instance_of(User)
        expect(response.status).to eq 302
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'must log out' do
      delete :destroy
      expect(controller.current_user).not_to be_an_instance_of(User)
    end
  end
end
