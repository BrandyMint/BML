require 'rails_helper'

describe Payments::ChargeBalanceFromTransaction do
  let(:account) { create :account, :with_billing }
  let(:gateway) { :cloudpayments }
  let(:token) { '123' }
  let(:transaction) do
    Payments::TransactionEntity.new(
      gateway: gateway,
      id: 123,
      amount: Money.new(5053)
    )
  end
  let(:card) do
    Payments::CardEntity.new(
      token: token,
      card_first_six: '123456',
      card_last_four: '1234',
      card_type: 'visa',
      issuer_bank_country: '',
      card_exp_date: '01/30',
      gateway: gateway
    )
  end

  subject do
    described_class.new(account: account, transaction: transaction, card: card)
  end

  describe '#call' do
    context 'w/ card' do
      it 'must charge balance' do
        expect_any_instance_of(Billing::PaymentChargeBalance).to receive(:call)
        subject.call
        expect(account.payment_accounts.count).to eq 1
        expect(account.payment_accounts.last.token).to eq token
      end
    end

    context 'w/out card' do
      let(:card) { nil }
      it 'must not save card' do
        expect_any_instance_of(Billing::PaymentChargeBalance).to receive(:call)
        subject.call
        expect(account.payment_accounts.count).to eq 0
      end
    end
  end
end
