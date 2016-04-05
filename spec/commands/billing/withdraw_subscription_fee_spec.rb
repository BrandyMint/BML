require 'rails_helper'

RSpec.describe Billing::WithdrawSubscriptionFee, openbill: true do
  let(:account) { create :account, :with_billing }
  let(:landing) { create :landing, account: account }
  let(:tariff) { build :tariff }

  subject { described_class.new(account: account, tariff: tariff, month: month) }

  describe '#call' do
    context 'total > 0' do
      let(:month) { Date.new 2016, 4 }
      let(:description) { 'description' }
      let(:to_amount) { Money.new(10_000, :rub) }
      let(:from_amount) { Money.new(0, :rub) - to_amount }
      let(:fee) { FeeResult.new total: to_amount, description: description }
      before do
        allow(subject).to receive(:fee).and_return(fee)
        subject.call
      end
      it 'makes transaction once' do
        expect(Openbill::Transaction.count).to eq 1
        expect(Openbill::Transaction.last.key).to eq "#{described_class::NS}:#{account.ident}:#{month}"
        expect(account.billing_account.amount).to eq from_amount
        expect(SystemRegistry[:subscriptions].reload.amount).to eq to_amount

        expect { subject.call }.to raise_error Sequel::UniqueConstraintViolation
      end
    end

    context 'total <= 0' do
      let(:month) { Date.new 2016, 4 }
      let(:description) { 'description' }
      let(:to_amount) { Money.new(-10_000, :rub) }
      let(:fee) { FeeResult.new total: to_amount, description: description }
      before do
        allow(subject).to receive(:fee).and_return(fee)
      end
      it 'raises error' do
        expect { subject.call }.to raise_error Sequel::CheckConstraintViolation
      end
    end
  end
end
