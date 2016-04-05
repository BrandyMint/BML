require 'rails_helper'

RSpec.describe 'viewer/show', type: :view do
  let(:viewer_uuid) { UUID.generate }
  let!(:variant) { create :variant }
  it 'удачно отрендерили' do
    render template: 'viewer/show', locals: {
      current_landing: variant.landing,
      variant:         variant,
      viewer_uid:      viewer_uuid
    }
    # div class="boxed-layout" data-reactid=".1dat5pfl1xc.0"><div class="PageEmptyPlaceholder" data-reactid=".1dat5pfl1xc.0.0"><h2 class="PageEmptyPlacehold
    expect(rendered).to include 'PageEmptyPlaceholder'
  end
end
