require 'rails_helper'

describe LeadMailer do
  let(:user) { create :user, :with_account }
  let(:membership) { user.memberships.first }
  let(:lead) { create :lead }
  let(:payload) { { 'lead_id' => lead.id, 'membership_id' => membership.id } }

  describe '#new_lead_email' do
    subject { described_class.new_lead_email [user.email], payload }

    it do
      expect(subject).to have_subject(/#{lead.number}/)
      expect(subject).to have_body_text lead.data.keys.first
    end
  end
end
