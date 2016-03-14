require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  include SystemControllerSupport

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response.status).to eq 200
    end
  end

  describe 'POST #create' do
    it 'redirects' do
      post :create, reset_password: { login: 123 }
      expect(response.status).to eq 200
    end
  end

  describe 'GET #edit' do
    it 'redirects' do
      get :edit, id: 'token'
      expect(response.status).to eq 302
    end

    context 'user found' do
      let!(:user) { create :user, reset_password_token: 123 }
      it 'returns http success' do
        get :edit, id: user.reset_password_token
        expect(response.status).to eq 200
      end
    end
  end

  describe 'PATCH #update' do
    it 'redirects' do
      patch :update, id: 'token'
      expect(response.status).to eq 302
    end

    context 'user found' do
      let!(:user) { create :user, reset_password_token: 123 }
      it 'redirects' do
        patch :update, id: user.reset_password_token, user: { password: 123 }
        expect(response.status).to eq 302
      end
    end
  end
end
