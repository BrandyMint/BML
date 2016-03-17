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
end
