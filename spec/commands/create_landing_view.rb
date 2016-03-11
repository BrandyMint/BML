require 'rails_helper'

RSpec.describe CreateLandingView do
  subject do
    described_class.new(
      viewer: viewer,
      variant: variant,
      url: url,
      utms: utms
    )
  end

  describe '#call' do
    context 'valid params' do
      let(:viewer) { create :viewer }
      let(:variant) { create :variant }
      let(:url) { 'url' }
      let(:utms) { ParamsUtmEntity.new(utm_source: 123).to_h }
      before { subject.call }
      it 'must create landing_view' do
        expect(viewer.views.last.utm_source).to eq utms[:utm_source]
        expect(viewer.views.last.url).to eq url
      end
    end
  end
end
