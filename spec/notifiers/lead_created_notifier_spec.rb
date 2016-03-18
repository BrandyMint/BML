require 'rails_helper'

RSpec.describe LeadCreatedNotifier do
  let!(:lead) { build :lead }
  let!(:account) { build :account }

  subject { described_class.new(lead: lead, account: account) }

  describe '#call' do
    it 'must send notifications' do
      expect(subject).to receive(:send_sms)
      expect(subject).to receive(:send_emails)
      subject.call
    end
  end
end
