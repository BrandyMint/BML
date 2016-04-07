require 'rails_helper'

RSpec.describe Billing::PaymentChargeBalance, openbill: true do
  let(:account) { create :account, :with_billing }
  let(:gateway) { :cloudpayments }
  let(:transaction_id) { '123' }

  subject { described_class.new(account: account, amount: to_amount, gateway: gateway, transaction_id: transaction_id) }

  describe '#call' do
    context 'amount > 0' do
      let(:to_amount) { Money.new(10_000, account.billing_account.amount_currency) }
      let(:from_amount) { -to_amount }
      before do
        subject.call
      end
      it 'makes transaction' do
        expect(Openbill::Transaction.count).to eq 1
        expect(Openbill::Transaction.last.key).to eq "#{described_class::NS}:#{gateway}:#{transaction_id}"
        expect(SystemRegistry[:payments].reload.amount).to eq from_amount
        expect(account.billing_account.amount).to eq to_amount
      end
    end

    context 'amount <= 0' do
      let(:to_amount) { Money.new(-10_000, account.billing_account.amount_currency) }
      it 'raises error' do
        expect { subject.call }.to raise_error Sequel::CheckConstraintViolation
      end
    end
  end
end
