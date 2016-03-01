require 'rails_helper'

RSpec.describe LeadCreator do
  let(:params) { {} }
  let(:cookies) { {} }

  subject { described_class.new(cookies: cookies, params: params) }

  describe '#call' do
    context 'no landing' do
      it { expect { subject.call }.to raise_error ActiveRecord::RecordNotFound }
    end

    context 'valid params' do
      let(:landing_version) { create :landing_version }
      let(:params) { { landing_version_uuid: landing_version.uuid, name: 'John Doe' } }
      let(:cookies) { {
        first_utm_source: '123',
        last_utm_source: '111',
      } }
      before { subject.call }
      it 'must create lead' do
        expect(landing_version.leads.last.first_utm_source).to eq '123'
      end
    end
  end
end
