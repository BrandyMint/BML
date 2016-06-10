require 'rails_helper'

RSpec.describe CloudPaymentsBalanceChargeWorker do
  subject do
    described_class.perform_async account.id, year, month
  end

  describe '#perform_async' do
    let(:account) { create :account, :with_billing, :with_payment_account }
    let!(:billing_account) { account.billing_account }
    let(:date) { Date.current.prev_month }
    let(:year) { date.year }
    let(:month) { date.month }
    let(:amount) { Money.new(10_000, billing_account.amount_currency) }
    before do
      billing_account.amount = Money.new(-10_000, billing_account.amount_currency)
    end
    context 'balance < 0' do
      it 'must call CloudPayments::RecurrentChargeBalance' do
        expect(CloudPayments::RecurrentChargeBalance)
          .to receive(:new)
          .with(account: account, amount: amount)
          .and_return(proc {})
        subject
      end
    end
  end
end
