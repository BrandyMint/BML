require 'rails_helper'

describe MembershipPolicy do
  let(:owner) { Membership.new role: :owner }
  let(:master) { Membership.new role: :master }
  let(:analyst) { Membership.new role: :analyst }
  let(:guest) { Membership.new role: :guest }

  describe 'update?' do
    multiassert_method do |actor, resource, context|
      described_class.new(context.send(actor), context.send(resource)).update?
    end

    multiassert :owner, owner: true,
                        master: true,
                        analyst: true,
                        guest: true

    multiassert :master, owner: false,
                         master: true,
                         analyst: true,
                         guest: true

    multiassert [:analyst, :guest], owner: false,
                                    master: false,
                                    analyst: false,
                                    guest: false
  end

  describe 'destroy?' do
    multiassert_method do |actor, resource, context|
      described_class.new(context.send(actor), context.send(resource)).destroy?
    end

    multiassert :owner, owner: true,
                        master: true,
                        analyst: true,
                        guest: true

    multiassert :master, owner: false,
                         master: true,
                         analyst: true,
                         guest: true

    multiassert [:analyst, :guest], owner: false,
                                    master: false,
                                    analyst: false,
                                    guest: false
  end
end
