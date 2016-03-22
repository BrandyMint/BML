require 'rails_helper'

RSpec.describe UserInvitable, type: :model do
  let!(:inviter) { create :user, :with_account }
  let!(:email)   { generate :invite_email }
  let!(:invite)  { create :invite, user_inviter: inviter, email: email }

  subject { build :user, email: email }

  describe '#activate_invites' do
    before { invite }

    context 'guest user passed' do
      it 'activates invite' do
        expect_any_instance_of(Invite).to receive(:accept!).with(subject)

        subject.send :activate_invites!
      end
    end
  end
end
