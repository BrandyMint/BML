require 'rails_helper'

RSpec.describe ChangeTariff do
  let!(:new_tariff) { create :tariff }
  let!(:account) { create :account }

  subject do
    described_class.new(account: account, tariff: new_tariff, date: date).perform!
  end

  describe do
    let(:date) { Date.parse '15-04-2016' }

    it do
      expect(subject).to be_a TariffMonth
      expect(subject).to include date
    end
  end
end
