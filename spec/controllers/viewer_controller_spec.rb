require 'rails_helper'

RSpec.describe ViewerController, type: :controller do
  include CurrentVariant
  let!(:landing) { create :landing }
  let!(:variant) { landing.default_variant }
  let!(:viewer)  { create :viewer, landing: landing }

  before do
    set_current_variant variant
    allow(controller).to receive(:current_viewer_uid).and_return(viewer.uid)
  end

  describe 'GET #show' do
    it 'returns http success' do
      expect(LandingViewWorker).to receive :perform_async
      expect_any_instance_of(TouchOrCreateViewer).to receive :call
      get :show
      expect(response.status).to eq 200
    end
  end
end
