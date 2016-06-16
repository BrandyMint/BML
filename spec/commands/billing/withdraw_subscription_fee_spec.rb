require 'rails_helper'

RSpec.describe Billing::WithdrawSubscriptionFee do
  let(:account) { create :account, :with_billing }
  let(:landing) { create :landing, account: account }
  let(:tariff) { build :tariff }
  let!(:billing_account) { account.billing_account }

  subject { described_class.new(account: account, tariff: tariff, month: month) }

  describe '#call' do
    context 'total > 0' do
      let(:month) { Date.current }
      let(:description) { 'description' }
      let(:to_amount) { Money.new(10_000, billing_account.amount_currency) }
      let(:fee) { FeeResult.new total: to_amount, description: description }
      it 'makes transaction' do
        expect(Openbill.service).to receive(:make_transaction)
        allow(subject).to receive(:fee).and_return(fee)
        subject.call
      end
    end
  end
end
