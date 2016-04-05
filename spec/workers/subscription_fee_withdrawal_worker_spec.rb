require 'rails_helper'

RSpec.describe SubscriptionFeeWithdrawalWorker, openbill: true do
  subject do
    described_class.perform_async account.id
  end

  describe '#perform_async' do
    let(:account) { create :account, :with_billing, :with_payment_account }
    let!(:landing) { create :landing, account: account, created_at: Time.current - 2.months }
    let(:withdrawal_params) do
      {
        account: account,
        tariff: account.current_tariff,
        month: Date.current.prev_month
      }
    end
    let(:withdrawal_instance) { Billing::WithdrawSubscriptionFee.new withdrawal_params }
    context 'balance < 0 and payment_accounts.present?' do
      it 'must perform CloudPaymentsBalanceChargeWorker' do
        expect(Billing::WithdrawSubscriptionFee)
          .to receive(:new)
          .with(withdrawal_params)
          .and_return(withdrawal_instance)
        expect(CloudPaymentsBalanceChargeWorker).to receive(:perform_async)
        subject
      end
    end
  end
end
