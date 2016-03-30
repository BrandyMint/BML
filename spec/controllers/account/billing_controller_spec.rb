require 'rails_helper'

RSpec.describe Account::BillingController, type: :controller do
  include AccountControllerSupport

  describe 'GET show' do
    it 'returns http success' do
      get :show
      expect(response.status).to eq 200
    end
  end

  describe 'PATCH update' do
    let(:new_tariff) { create :tariff }
    it 'redirects' do
      patch :update, account: { tariff_id: new_tariff.id }
      expect(response.status).to eq 302
    end
  end

  describe 'DELETE destroy' do
    let(:old_tariff) { create :tariff }
    let(:new_tariff) { create :tariff }
    let!(:tariff_change) do
      create :tariff_change, account: account,
                             from_tariff: old_tariff,
                             to_tariff: new_tariff,
                             deleted_at: nil,
                             activates_at: 1.day.since
    end
    it 'redirects' do
      expect_any_instance_of(TariffChange).to receive :destroy!
      delete :destroy
      expect(response.status).to eq 302
    end
  end
end
