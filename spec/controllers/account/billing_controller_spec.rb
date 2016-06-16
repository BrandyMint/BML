require 'rails_helper'

RSpec.describe Account::BillingController, type: :controller do
  include AccountControllerSupport
  let(:transactions) { double reverse_order: {} }

  describe 'GET show' do
    it 'returns http success' do
      expect(Openbill.service).to receive(:account_transactions).and_return(transactions)
      get :show
      expect(response.status).to eq 200
    end
  end
end
