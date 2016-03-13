require 'rails_helper'

RSpec.describe CreateLead do
  let(:data) { {} }
  let(:cookies) { {} }
  let(:viewer_uid) { 'xxx' }
  let(:variant) { nil }

  subject do
    described_class.new(data: data,
                        variant: variant,
                        cookies: cookies,
                        viewer_uid: viewer_uid)
  end

  before do
    Viewer.touch_or_create viewer_uid
  end

  describe '#call' do
    context 'valid params' do
      let(:variant) { create :variant }
      let(:data) { { name: 'John Doe' } }
      let(:utm_source) { '123' }
      let(:cookies) do
        {
          first_utm_source: utm_source,
          last_utm_source: '111'
        }
      end
      before do
        allow(subject).to receive(:update_utm_values)
        subject.call
      end
      it 'must create lead' do
        expect(variant.leads.last.first_utm_source).to eq utm_source
        expect(variant.leads.last.viewer).to be_a Viewer
      end
    end
  end
end
