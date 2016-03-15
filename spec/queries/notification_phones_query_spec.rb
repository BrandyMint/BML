require 'rails_helper'

RSpec.describe NotificationPhonesQuery do
  let!(:user) { create :user, :with_account }
  let!(:user2) { create :user }
  let!(:user3) { create :user }
  let!(:account) { user.memberships.first.account }

  before do
    user.update_column :phone_confirmed_at, Time.zone.now
    user2.update_column :phone_confirmed_at, Time.zone.now

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

  subject { described_class.new(account_id: account.id) }

  describe '#call' do
    let(:phones) { subject.call }
    it 'must return phones array' do
      expect(phones).to include(user.phone)
      expect(phones).not_to include(user2.phone)
      expect(phones).not_to include(user3.phone)
    end
  end
end
