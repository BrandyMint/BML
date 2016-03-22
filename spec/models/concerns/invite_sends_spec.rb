require 'rails_helper'

RSpec.describe InviteSends, type: :model do
  let!(:user) { create :user, :with_account }

  it 'sends email' do
    expect_any_instance_of(InviteMailer).to receive(:new_invite)
    create :invite, email: generate(:invite_email), phone: nil
  end

  it 'sends sms' do
    expect(SmsWorker).to receive(:perform_async)
    create :invite, phone: generate(:invite_phone), email: nil, user_inviter: user
  end
end
