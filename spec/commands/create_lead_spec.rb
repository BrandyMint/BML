require 'rails_helper'

RSpec.describe CreateLead do
  let(:viewer_uid) { 'xxx' }
  let(:variant) { create :variant }
  let(:landing_id) { variant.landing_id }
  let(:remote_ip) { '127.0.0.1' }
  let(:user_agent) { 'browser' }

  subject do
    described_class.new(data: data,
                        variant: variant,
                        tracking: tracking,
                        cookies: cookies,
                        viewer_uid: viewer_uid)
  end

  before do
    TouchOrCreateViewer.new(viewer_uid: viewer_uid, remote_ip: remote_ip, user_agent: user_agent, landing_id: landing_id).call
  end

  describe 'нормальная заявка' do
    context 'valid params' do
      let(:data) { { name: 'John Doe' } }
      let(:utm_source) { '123' }
      let(:tracking) { '' }
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

  describe 'пустая заявка' do
    context 'valid params' do
      let(:data) { { name: '', email: '' } }
      let(:utm_source) { '123' }
      let(:tracking) { '' }
      let(:cookies) do
        {
          first_utm_source: utm_source,
          last_utm_source: '111'
        }
      end
      it 'не принимается' do
        expect { subject.call }.to raise_error CreateLead::BlankLeadError
      end
    end
  end
end
