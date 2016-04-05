require 'rails_helper'

RSpec.describe Account::PaymentsController, type: :controller do
  include AccountControllerSupport

  describe 'POST create' do
    it 'returns http success' do
      expect(controller).to receive(:pay_balance)
      post :create, balance_payment_form: { name: 'asdf' }
      expect(response.status).to eq 302
    end
  end
end
