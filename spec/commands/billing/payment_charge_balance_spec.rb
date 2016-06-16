require 'rails_helper'

RSpec.describe Billing::PaymentChargeBalance do
  let(:account) { create :account, :with_billing }
  let(:gateway) { :cloudpayments }
  let(:transaction_id) { '123' }
  let!(:billing_account) { account.billing_account }

  subject { described_class.new(account: account, amount: to_amount, gateway: gateway, transaction_id: transaction_id) }

  describe '#call' do
    context 'amount > 0' do
      let(:to_amount) { Money.new(10_000, billing_account.amount_currency) }
      it 'makes transaction' do
        expect(Openbill.service).to receive(:make_transaction)
        subject.call
      end
    end
  end
end
