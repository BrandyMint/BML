require 'rails_helper'

RSpec.describe CloudPaymentsBalanceChargeWorker, openbill: true do
  subject do
    described_class.perform_async account.id, year, month
  end

  describe '#perform_async' do
    let(:account) { create :account, :with_billing, :with_payment_account }
    let(:date) { Date.current.prev_month }
    let(:year) { date.year }
    let(:month) { date.month }
    let(:amount) { Money.new(10_000, account.billing_account.amount_currency) }
    context 'balance < 0' do
      before do
        Openbill.current.make_transaction(
          from: account.billing_account,
          to: SystemRegistry[:subscriptions],
          key: [:subscription, account.ident, month].join(':'),
          amount: amount,
          details: '',
          meta: {
            gateway: :cloudpayments,
            month: month,
            tariff_id: account.current_tariff.id
          }
        )
      end
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
