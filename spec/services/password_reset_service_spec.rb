require 'rails_helper'

RSpec.describe PasswordResetService do
  let!(:user) { create :user }

  subject { described_class.new(login: login) }

  describe '#call' do
    context 'phone?' do
      let(:login) { user.phone }
      it 'must send sms' do
        expect_any_instance_of(User).to receive(:change_password!)
        expect(SmsWorker).to receive(:perform_async)
        subject.call
      end
    end

    context 'email?' do
      let(:login) { user.email }
      it 'must send email' do
        expect_any_instance_of(User).to receive(:deliver_reset_password_instructions!)
        subject.call
      end
    end

    context 'invalid login' do
      let(:login) { 'invalid login' }
      it 'must raise error' do
        expect { subject.call }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
