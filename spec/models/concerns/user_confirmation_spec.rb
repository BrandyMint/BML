require 'rails_helper'

RSpec.describe UserConfirmation, type: :model do
  let!(:pin_code) { SecureRandom.hex(3) }
  let(:user) { create :user }

  describe 'phone confirmation' do
    it do
      expect(user.phone_confirmed?).to be false
      expect(user.phone_confirmations).to have(1).items
    end

    context 'phone changed' do
      let!(:user) { create :user, phone_confirmed_at: Time.zone.now }
      let!(:new_phone) { generate :user_phone }

      it 'must reset confirmation and set pin' do
        expect(SmsWorker).to receive(:perform_async)
        user.update_attribute :phone, new_phone
        expect(user.phone_confirmed?).to eq false
        expect(user.phone_confirmations.by_phone(new_phone)).to be_exists
      end
    end

    describe '#confirm_phone!' do
      before { user.confirm_phone! }
      it 'must confirm phone' do
        expect(user.phone_confirmed?).to eq true
      end
    end
  end

  describe 'email confirmation' do
    it do
      expect(user.email_confirmed?).to be false
    end

    context 'email changed' do
      let!(:user) { create :user, email_confirmed_at: Time.zone.now }
      it 'must reset confirmation and set pin' do
        # TODO
        # expect(UserMailer).to receive(:email_confirmation).with(user.id)
        user.update_attribute :email, generate(:user_email)
        expect(user.email_confirmed?).to eq false
      end
    end

    context '#confirm_email!' do
      before { user.confirm_email! }
      it 'must confirm email' do
        expect(user.email_confirmed?).to eq true
      end
    end

    context 'email has not changed' do
      let!(:user) { create :user }
      it 'must not deliver mail' do
        expect(UserMailer).to_not receive(:email_confirmation)
        user.update_attribute :name, 'asdsada'
      end
    end
  end
end
