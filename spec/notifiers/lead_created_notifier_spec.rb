require 'rails_helper'

RSpec.describe LeadCreatedNotifier do
  let!(:account) { create :account, :with_smsc }
  let!(:membership) { create :membership, :confirmed, account: account }
  let!(:landing) { create :landing, account: account }
  let!(:lead) { create :lead, landing: landing }

  subject { described_class.new(lead: lead, account: account) }

  describe '#call' do
    it 'must send notifications' do
      expect(LeadCreatedNotifier::Notify).to receive(:send_sms)
      expect(LeadCreatedNotifier::Notify).to receive(:send_email)
      subject.call
    end
  end
end
