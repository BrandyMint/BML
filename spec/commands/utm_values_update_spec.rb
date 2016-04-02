require 'rails_helper'

RSpec.describe UtmValuesUpdate do
  let(:lead) { create :lead, :with_utm_fields }

  subject { described_class.new(lead: lead) }

  describe '#call' do
    it 'must upsert utm values' do
      subject.call
      expect(lead.landing.utm_values.count).to eq TrackingSupport::UTM_FIELD_DEFINITIONS.size

      subject.call
      expect(lead.landing.utm_values.count).to eq TrackingSupport::UTM_FIELD_DEFINITIONS.size
    end
  end
end
