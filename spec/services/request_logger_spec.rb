require 'rails_helper'

RSpec.describe RequestLogger do
  subject do
    described_class.new(
      worker: worker,
      request: request,
      viewer: viewer,
      variant: variant
    )
  end

  describe '#call' do
    context 'valid params' do
      let(:worker)  { double }
      let(:request) { double(params: {}, referer: 'ref', original_url: 'url') }
      let(:variant) { double(id: 1) }
      let(:viewer)  { double(uid: 1) }
      it 'must start logging worker' do
        expect(worker).to receive(:perform_async)
        subject.call
      end
    end
  end
end
