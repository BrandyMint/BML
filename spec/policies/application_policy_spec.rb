require 'rails_helper'

describe ApplicationPolicy do
  let(:owner) { Membership.new role: :owner }
  let(:master) { Membership.new role: :master }
  let(:analyst) { Membership.new role: :analyst }
  let(:guest) { Membership.new role: :guest }

  subject { described_class }

  describe 'Basic permissions' do
    context 'with persisted and present resource' do
      multiassert_method do |actor, resource, context|
        member = context.send(actor)
        described_class.new(member, OpenStruct.new(persisted?: true, present?: true)).send(resource)
      end

      multiassert :owner, index?: true,
                          show?: true,
                          create?: true,
                          new?: true,
                          update?: true,
                          edit?: true,
                          destroy?: true

      multiassert :master, index?: true,
                           show?: true,
                           create?: true,
                           new?: true,
                           update?: true,
                           edit?: true,
                           destroy?: true

      multiassert :analyst, index?: true,
                            show?: true,
                            create?: false,
                            new?: false,
                            update?: false,
                            edit?: false,
                            destroy?: false

      multiassert :guest, index?: true,
                          show?: true,
                          create?: false,
                          new?: false,
                          update?: false,
                          edit?: false,
                          destroy?: false
    end

    context 'with not persisted resource' do
      multiassert_method do |actor, resource, context|
        member = context.send(actor)
        described_class.new(member, OpenStruct.new(persisted?: false, present?: true)).send(resource)
      end

      multiassert :owner, index?: true,
                          show?: true,
                          create?: true,
                          new?: true,
                          update?: true,
                          edit?: true,
                          destroy?: false

      multiassert :master, index?: true,
                           show?: true,
                           create?: true,
                           new?: true,
                           update?: true,
                           edit?: true,
                           destroy?: false

      multiassert :analyst, index?: true,
                            show?: true,
                            create?: false,
                            new?: false,
                            update?: false,
                            edit?: false,
                            destroy?: false

      multiassert :guest, index?: true,
                          show?: true,
                          create?: false,
                          new?: false,
                          update?: false,
                          edit?: false,
                          destroy?: false
    end
  end
end
