require 'rails_helper'

RSpec.describe PerLandingFeeStrategy do
  let!(:account) { create :account }

  subject { described_class.new(account: account, price: price_per_site, month: month) }

  describe '#call' do
    let!(:landing1) { create :landing, account: account }
    let!(:landing2) { create :landing, account: account }
    let(:month) { Date.current }

    let(:price_per_site) { Money.new(30_000, :rub) }
    let(:description) { 'description' }
    let(:landing_fee) { FeeResult.new(total: price_per_site, description: description) }
    let(:total) { price_per_site * account.landings.count }
    let(:result) { subject.call }
    before do
      allow(subject).to receive(:landing_fee).and_return(landing_fee)
    end
    it do
      expect(result.total).to eq total
      expect(result.description.scan(description).size).to eq 2
    end
  end
end
