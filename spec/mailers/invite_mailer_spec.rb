require 'rails_helper'

describe InviteMailer do
  let(:invite) { create :invite }

  describe '#new_invite' do
    subject { described_class.new_invite invite.id }

    it do
      expect(subject).to have_body_text invite.url
      expect(subject).to have_body_text invite.account.to_s
    end
  end

  describe '#added_to_account' do
    let(:user) { create :user }
    let(:inviter) { create :user, :with_account }
    let(:account) { inviter.memberships.first.account }
    let(:role) { :guest }
    subject { described_class.added_to_account inviter.id, user.id, account.id, role }

    it do
      expect(subject).to have_body_text inviter.name
      expect(subject).to have_body_text account.to_s
    end
  end
end
