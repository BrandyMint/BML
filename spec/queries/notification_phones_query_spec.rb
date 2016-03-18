require 'rails_helper'

RSpec.describe NotificationPhonesQuery do
  let!(:user) { create :user, :confirmed, :with_account }
  let!(:user2) { create :user, :confirmed }
  let!(:user3) { create :user }
  let!(:account) { user.memberships.first.account }

  before do
    user.memberships.first.update(
      sms_notification: true
    )

    user2.memberships.create!(
      account: account,
      role: Membership::DEFAULT_ROLE,
      sms_notification: false
    )

    user3.memberships.create!(
      account: account,
      role: Membership::DEFAULT_ROLE,
      sms_notification: true
    )
  end

  subject { described_class.new(account_id: account.id).call }

  it 'must return phones array' do
    expect(subject).to include(user.phone)
    expect(subject).not_to include(user2.phone)
    expect(subject).not_to include(user3.phone)
  end
end
