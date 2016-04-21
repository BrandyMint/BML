require 'rails_helper'

RSpec.describe Account::TariffController, type: :controller do
  include AccountControllerSupport
  let!(:tariff) { create :tariff }

  describe 'PATCH update' do
    it 'returns http success' do
      patch :update, id: tariff.id
      expect(response.status).to eq 302
    end
  end
end
