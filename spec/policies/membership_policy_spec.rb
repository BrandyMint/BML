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
    context 'self' do
      multiassert_method do |actor, resource, context|
        described_class.new(context.send(actor), context.send(resource)).destroy?
      end

      multiassert :owner, owner: false,
                          master: true,
                          analyst: true,
                          guest: true

      multiassert :master, owner: false,
                           master: false,
                           analyst: true,
                           guest: true

      multiassert [:analyst, :guest], owner: false,
                                      master: false,
                                      analyst: false,
                                      guest: false
    end

    context 'another member' do
      let(:another_owner) { Membership.new role: :owner }
      let(:another_master) { Membership.new role: :master }
      let(:another_analyst) { Membership.new role: :analyst }
      let(:another_guest) { Membership.new role: :guest }
      multiassert_method do |actor, resource, context|
        described_class.new(context.send(actor), context.send(resource)).destroy?
      end

      multiassert :owner, another_owner: false,
                          another_master: true,
                          another_analyst: true,
                          another_guest: true

      multiassert :master, another_owner: false,
                           another_master: true,
                           another_analyst: true,
                           another_guest: true

      multiassert [:analyst, :guest], another_owner: false,
                                      another_master: false,
                                      another_analyst: false,
                                      another_guest: false
    end
  end
end
