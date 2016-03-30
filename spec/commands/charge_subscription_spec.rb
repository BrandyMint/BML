require 'rails_helper'

RSpec.describe ChargeSubscription, type: :model do
  let(:account) { create :account, :with_billing }
  let(:landing) { create :landing, account: account }
  let(:tariff) { build :tariff }

  subject { described_class.new(account: account, tariff: tariff, month: month) }

  around :each do |example|
    connection = Openbill.current.send(:database).instance_variable_get('@db')
    connection.transaction do
      example.run
      # force rollback
      raise Sequel::Error::Rollback
    end
  end

  describe '#call' do
    context 'total > 0' do
      let(:month) { Date.new 2016, 4 }
      let(:description) { 'description' }
      let(:total) { Money.new(10000, :rub) }
      let(:fee) { FeeResult.new total: total, description: description }
      before do
        allow(subject).to receive(:fee).and_return(fee)
        subject.call
      end
      it 'makes transaction' do
        expect(Openbill::Transaction.count).to eq 1
        expect(Openbill::Transaction.last.key).to eq "subscription-#{account.id}-#{month}"
        expect(SystemRegistry[:subscriptions].reload.amount).to eq total
        expect(account.billing_account.amount).to eq (Money.new(0, :rub) - total)
      end
    end

    context 'total <= 0' do
      let(:month) { Date.new 2016, 4 }
      let(:description) { 'description' }
      let(:total) { Money.new(-10000, :rub) }
      let(:fee) { FeeResult.new total: total, description: description }
      before do
        allow(subject).to receive(:fee).and_return(fee)
      end
      it 'does nothing' do
        expect_any_instance_of(Openbill::Service).not_to receive(:make_transaction)
        subject.call
        expect(Openbill::Transaction.count).to eq 0
        expect(SystemRegistry[:subscriptions].reload.amount).to eq Money.new(0, :rub)
        expect(account.billing_account.amount).to eq Money.new(0, :rub)
      end
    end
  end
end
