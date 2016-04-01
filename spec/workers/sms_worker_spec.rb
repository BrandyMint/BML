require 'rails_helper'

RSpec.describe SmsWorker do
  let(:phones) { '+7123213, +12312321' }
  let(:credentials) { SmsWorker::Credentials.new }
  let(:message) { ' some text ' }

  subject do
    described_class.perform_async credentials, phones, message
  end

  describe do
    let(:credentials) { SmsWorker::SystemSender }
    it do
      expect_any_instance_of(described_class).to receive(:perform)
        .with(credentials.to_hash.stringify_keys, phones, message)
      described_class.perform_async credentials, phones, message
    end
  end

  describe do
    let(:account) { create :account, :with_smsc }
    let(:credentials) { account.sms_credentials }
    it do
      expect_any_instance_of(described_class).to receive(:perform)
        .with(credentials.to_hash.stringify_keys, phones, message)
      described_class.perform_async credentials, phones, message
    end
  end

  describe do
    let(:phones) { '+7123213, +12312321' }
    subject do
      described_class.new.perform credentials, phones, message
    end
    it do
      expect(subject).to be_a AccountSmsLogEntity
    end
  end

  describe do
    let(:phones) { [1_321_312_321_321, 132_312_312_321] }
  end

  # errors
  # context
end
