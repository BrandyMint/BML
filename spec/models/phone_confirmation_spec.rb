require 'rails_helper'

RSpec.describe PhoneConfirmation, type: :model do
  let(:phone) { '+79033891228' }
  let(:user) { create :user }

  before { user.update_column :phone, phone }

  it do
    pc = described_class.new phone: phone, user: user
    expect(pc).to receive(:deliver_pin_code!)
    pc.save!
    expect(pc).to be_persisted
  end

  context 'если подтверждается телефон, то он подтверждается у пользователя' do
    let(:account) { create :account }
    let!(:membership) { create :membership, account: account, user: user }
    let(:phone_confirmation) { create :phone_confirmation, user: user, phone: phone }
    it do
      phone_confirmation.send(:confirm!)
      expect(user.reload.phone_confirmed?).to be_truthy
    end
  end
end
