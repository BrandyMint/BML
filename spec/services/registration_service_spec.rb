require 'rails_helper'

RSpec.describe RegistrationService do
  let(:params) { attributes_for :user }
  let(:form) { RegistrationForm.new params }

  subject { described_class.new(form: form) }

  describe '#call' do
    context 'valid params' do
      before { subject.call }
      it 'must create user with account' do
        user = User.find_by_email(params[:email])
        expect(user).to be_persisted
        expect(user.accounts.count).to be > 0
      end
    end

    context 'invalid params' do
      let(:form) { RegistrationForm.new {} }
      it 'must raise error' do
        expect { subject.call }.to raise_error ActiveRecord::RecordInvalid
      end
    end

    context 'user duplicate' do
      let!(:user) { create :user }
      let!(:params) { user.attributes }
      it 'must raise error' do
        expect { subject.call }.to raise_error described_class::UserDuplicate
      end
    end
  end
end
