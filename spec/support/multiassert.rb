module RSpec
  module Core
    class ExampleGroup
      def self.multiassert_method(&block)
        let(:multiassert_method_block) { block }
      end

      def self.multiassert(actors, conditions)
        actors = actors.is_a?(Array) ? actors : [actors]

        conditions.each do |resource, assertion|
          actors.each do |actor|
            it "#{actor} #{resource} #{assertion}" do
              expect(multiassert_method_block.call(actor, resource, self)).to eq assertion
            end
          end
        end
      end
    end
  end
end
