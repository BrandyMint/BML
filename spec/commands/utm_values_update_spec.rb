require 'rails_helper'

RSpec.describe UtmValuesUpdate do
  let(:lead) { build :lead, :with_utm_fields }

  subject { described_class.new(lead: lead) }

  describe '#call' do
    it 'must upsert utm values' do
      subject.call
      expect(lead.landing.utm_values.count).to eq Lead.utm_fields.size

      subject.call
      expect(lead.landing.utm_values.count).to eq Lead.utm_fields.size
    end
  end
end
