require 'rails_helper'

RSpec.describe LeadCreatedNotifier do
  let!(:phones) { [] }
  let!(:email_members) { [] }
  let!(:lead) { build :lead }

  subject { described_class.new(phones: phones, email_members: email_members, lead: lead) }

  describe '#call' do
    it 'must send notifications' do
      expect(subject).to receive(:send_sms)
      expect(subject).to receive(:send_emails)
      subject.call
    end
  end
end
