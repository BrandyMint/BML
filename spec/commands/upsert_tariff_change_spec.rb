require 'rails_helper'

RSpec.describe UpsertTariffChange do
  let(:old_tariff)  { create :tariff }
  let(:new_tariff)  { create :tariff }
  let!(:account)    { create :account, tariff: old_tariff }

  subject { described_class.new(account: account, tariff: tariff) }

  describe '#call' do
    context 'same tariff' do
      let(:tariff) { old_tariff }
      before { subject.call }
      it 'does nothing' do
        expect(account.tariff_changes.count).to eq 0
        expect(account.next_tariff_change).to eq nil
      end
    end

    context 'no tariff_change' do
      let(:tariff) { new_tariff }
      it 'must create tariff_change' do
        expect(account.tariff_changes.count).to eq 0
        subject.call
        expect(account.next_tariff_change).to be_a TariffChange
      end
    end

    context 'tariff_change present' do
      let(:tariff) { create :tariff }
      let(:activates_at) do
        time = Time.zone.today
        Time.zone.local time.year, time.next_month.month
      end
      let!(:tariff_change) do
        create :tariff_change, account: account,
                               from_tariff: old_tariff,
                               to_tariff: new_tariff,
                               activates_at: activates_at
      end
      before { subject.call }
      it 'must update tariff_change' do
        expect(account.next_tariff_change).to eq tariff_change.reload
        expect(tariff_change.to_tariff).to eq tariff
        expect(tariff_change.archived?).to eq false
        expect(tariff_change.created_at).not_to eq tariff_change.updated_at
      end
    end
  end
end
