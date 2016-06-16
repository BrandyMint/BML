require 'rails_helper'

RSpec.describe AccountBilling, type: :model do
  let!(:account) { create :account, :with_billing }

  it do
    expect(account.amount).to eq Money.new(0)
  end
end
