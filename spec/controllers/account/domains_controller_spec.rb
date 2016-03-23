require 'rails_helper'

RSpec.describe Account::DomainsController, type: :controller do
  include AccountControllerSupport

  describe 'GET show' do
    it 'returns http success' do
      get :show
      expect(response.status).to eq 200
    end
  end

  describe 'PATCH update' do
    let(:account_params) { { web_addresses_attributes: { 0 => { id: 1, suggested_domain: 'abc.com' } } } }
    it 'redirects' do
      patch :update, id: account.id, account: account_params
      expect(response.status).to eq 302
    end
  end
end
