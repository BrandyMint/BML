require 'rails_helper'

RSpec.describe Account::BillingController, type: :controller do
  include AccountControllerSupport

  describe 'GET show' do
    it 'returns http success' do
      get :show
      expect(response.status).to eq 200
    end
  end
end
