require 'rails_helper'

RSpec.describe CreateLead do
  let(:params) { {} }
  let(:cookies) { {} }
  let(:session) { double(id: 'xxx') }
  let(:request) { double(cookies: cookies, params: params, session: session) }

  subject { described_class.new(request: request) }

  describe '#call' do
    context 'no landing' do
      it { expect { subject.call }.to raise_error ActiveRecord::RecordNotFound }
    end

    context 'valid params' do
      let(:variant) { create :variant }
      let(:params) { { variant_uuid: variant.uuid, name: 'John Doe' } }
      let(:cookies) do
        {
          first_utm_source: '123',
          last_utm_source: '111'
        }
      end
      before do
        allow(subject).to receive(:update_utm_values)
        subject.call
      end
      it 'must create lead' do
        expect(variant.leads.last.first_utm_source).to eq '123'
        expect(variant.leads.last.viewer).to be_a Viewer
      end
    end
  end
end
