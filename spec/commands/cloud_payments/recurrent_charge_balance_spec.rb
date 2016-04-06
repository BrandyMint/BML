require 'rails_helper'

describe CloudPayments::RecurrentChargeBalance, vcr: true, openbill: true do
  let(:account)      { create :account, :with_payment_account, payment_token: payment_token, ident: 'root' }
  let!(:amount)      { Money.new(5053, account.billing_account.amount_currency) }
  let!(:valid_token) { '2F725BBD1F405A1ED0336ABAF85DDFEB6902A9984A76FD877C3B5CC3B5085A82' }
  let!(:invalid_token) { 'ABBEF19476623CA56C17DA75FD57734DBF82530686043A6E491C6D71BEFE8F6E' }

  subject { described_class.new(account: account, amount: amount) }

  describe '#call' do
    context 'w/ valid params' do
      let(:payment_token) { valid_token }

      before { subject.call }
      it 'must charge balance' do
        expect(Openbill::Transaction.count).to eq 1
        expect(account.billing_account.amount).to eq amount
      end
    end

    context 'w/ banking errors (InvalidToken)' do
      let(:payment_token) { invalid_token }
      it 'must raise CloudPaymentsError' do
        expect { subject.call }.to raise_error(CloudPayments::Client::GatewayError)
      end
    end
  end
end
