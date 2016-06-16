require 'rails_helper'

RSpec.describe Billing::GiftChargeBalance do
  let(:user) { build_stubbed :user }
  let(:account) { create :account, :with_billing }
  let(:description) { 'description' }
  let!(:billing_account) { account.billing_account }

  subject do
    described_class.new(
      account: account,
      amount: to_amount,
      description: description,
      user: user
    )
  end

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
