require 'rails_helper'

RSpec.describe AccountFeatures, type: :model do
  let(:tariff) { build :tariff }

  subject { described_class.new(account: account, tariff: account.current_tariff) }

  describe '#leads_limit' do
    context 'paid' do
      let(:account) { build :account }
      before do
        allow(subject).to receive(:paid?).and_return true
      end
      it 'returns nil' do
        expect(subject.leads_limit).to eq nil
      end
    end

    context 'free days and free leads' do
      let(:account) { build_stubbed :account, created_at: Time.zone.now - tariff.free_days_count.days }
      before do
        allow(subject).to receive(:paid?).and_return false
      end
      it 'returns nil' do
        expect(subject.leads_limit).to eq nil
      end
    end

    context 'not paid, no free days or free leads' do
      let(:account) { build_stubbed :account, created_at: Time.zone.now - (tariff.free_days_count.days.days + 1) }
      before do
        allow(subject).to receive(:paid?).and_return false
      end
      it 'returns limit' do
        expect(subject.leads_limit).to eq tariff.blocked_leads_count
      end
    end
  end
end
