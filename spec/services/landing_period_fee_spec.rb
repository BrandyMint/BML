require 'rails_helper'

RSpec.describe LandingPeriodFee do
  let!(:landing) { build :landing }
  let!(:price) { Money.new(30_000, :rub) }

  subject { described_class.new(landing: landing, price: price, month: month) }

  describe '#call' do
    let(:month) { Date.new 2016, 4 }
    let(:used_period) { UsedPeriodResult.new(ratio: 0.33, used_days: 10, period_days: 30) }
    let(:total) { price * used_period.ratio }
    let(:result) { subject.call }
    before do
      allow(subject).to receive(:used_period).and_return(used_period)
    end
    it do
      expect(result.total).to eq total
      expect(result.description).to include landing.title
      expect(result.description).to include used_period.used_days.to_s
      expect(result.description).to include used_period.period_days.to_s
      expect(result.description).to include total.to_i.to_s
    end
  end
end
