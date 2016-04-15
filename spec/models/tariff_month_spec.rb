require 'rails_helper'

RSpec.describe TariffMonth, type: :model do
  let(:date) { Date.parse('15-04-2016') }
  let!(:tariff) { create :tariff_month, month: date }

  before do
    create :tariff_month, month: date - 1.month
  end

  it { expect(tariff).to be_persisted }
  it { expect(tariff.include?(date)).to be_truthy }
  it { expect(tariff.include?(date + 20.days)).to be_falsey }
  it { expect(described_class.for_date(date).first).to eq tariff }

  describe '#nearest_to' do
    let(:search_date) { date + 1.month }
    it { expect(described_class.nearest_to(search_date).first).to eq tariff }
  end
end
