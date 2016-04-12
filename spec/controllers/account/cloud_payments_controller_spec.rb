require 'rails_helper'

RSpec.describe Account::CloudPaymentsController, type: :controller do
  include AccountControllerSupport

  describe 'GET new' do
    it 'returns http success' do
      get :new
      expect(response.status).to eq 200
    end
  end

  describe 'POST create' do
    it 'returns http success' do
      expect(controller).to receive(:one_time_payment)
      expect(controller).to receive(:charge_balance)
      post :create, cloud_payments_form: { name: 'asdf' }
      expect(response.status).to eq 302
    end
  end

  describe 'POST post3ds' do
    it 'returns http success' do
      expect(controller).to receive(:handle_3ds)
      expect(controller).to receive(:unset_save_card_flag)
      expect(controller).to receive(:charge_balance)
      post :post3ds, 'MD' => 123, 'PaRes' => 123
      expect(response.status).to eq 302
    end
  end
end
