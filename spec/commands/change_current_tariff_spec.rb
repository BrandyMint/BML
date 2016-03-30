require 'rails_helper'

RSpec.describe ChangeCurrentTariff do
  let(:old_tariff)    { create :tariff }
  let(:new_tariff)    { create :tariff }
  let!(:account)      { create :account, tariff: old_tariff }
  let(:tariff_change) do
    create :tariff_change, account: account,
                           from_tariff: old_tariff,
                           to_tariff: new_tariff,
                           activates_at: Time.current
  end

  subject { described_class.new(tariff_change: tariff_change) }

  describe '#call' do
    context 'nil' do
      let(:tariff_change) { nil }
      before { subject.call }
      it 'does nothing' do
        expect(account.tariff).to eq old_tariff
      end
    end

    context 'archived tariff' do
      let(:new_tariff) { create :tariff, deleted_at: Time.current }
      before { subject.call }
      it 'destroys tariff_change' do
        expect(account.tariff).to eq old_tariff
        expect(account.next_tariff_change).to eq nil
      end
    end

    context 'present' do
      before { subject.call }
      it 'must change tariff' do
        expect(account.tariff).to eq new_tariff
        expect(tariff_change.archived?).to eq true
        expect(account.next_tariff_change).to eq nil
      end
    end
  end
end
