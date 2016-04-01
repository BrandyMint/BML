require 'rails_helper'

RSpec.describe Account::SmsController, type: :controller do
  include AccountControllerSupport

  describe 'GET show' do
    it 'returns http success' do
      get :show
      expect(response.status).to eq 200
    end
  end

  describe 'PATCH update' do
    it 'redirects' do
      patch :update, id: account.id, account: { smsc_login: 'A' }
      expect(response.status).to eq 302
    end
  end
end
