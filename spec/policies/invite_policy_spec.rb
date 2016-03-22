require 'rails_helper'

describe InvitePolicy do
  let(:owner) { build_stubbed :membership, role: :owner }
  let(:master) { build_stubbed :membership, role: :master }
  let(:analyst) { build_stubbed :membership, role: :analyst }
  let(:guest) { build_stubbed :membership, role: :guest }

  subject { described_class }

  describe 'destroy?' do
    context 'self' do
      multiassert_method do |_actor, resource, context|
        member = context.send(resource)
        described_class.new(member, Invite.new(user_inviter_id: member.user.id)).destroy?
      end

      multiassert nil, owner: true,
                       master: true,
                       analyst: true,
                       guest: true
    end

    context 'others' do
      multiassert_method do |_actor, resource, context|
        described_class.new(context.send(resource), context.build_stubbed(:invite)).destroy?
      end

      multiassert nil, owner: true,
                       master: true,
                       analyst: false,
                       guest: false
    end
  end
end
