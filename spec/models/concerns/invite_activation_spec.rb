require 'rails_helper'

RSpec.describe InviteActivation, type: :model do
  let(:account) { create :account }
  let(:guest) { create :user }

  describe '#find_and_bind_users' do
    subject { Invite.new email: guest.email, account: account }

    it do
      expect(subject.find_and_bind_users).to include(guest)
    end
  end
end
