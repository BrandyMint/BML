require 'rails_helper'

RSpec.describe Billing::GiftChargeBalance, openbill: true do
  let(:user) { build_stubbed :user }
  let(:account) { create :account, :with_billing }
  let(:description) { 'description' }

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
      let(:to_amount) { Money.new(10_000, account.billing_account.amount_currency) }
      let(:from_amount) { -to_amount }
      before do
        subject.call
      end
      it 'makes transaction' do
        expect(Openbill::Transaction.count).to eq 1
        expect(Openbill::Transaction.last.key).to eq "#{described_class::NS}:#{account.ident}:#{Time.current.beginning_of_hour.to_i}"
        expect(Openbill::Transaction.last.details).to include description
        expect(Openbill::Transaction.last.meta['user_id']).to eq user.id.to_s
        expect(SystemRegistry[:gift].reload.amount).to eq from_amount
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
