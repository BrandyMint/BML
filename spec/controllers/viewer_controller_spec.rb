require 'rails_helper'

RSpec.describe ViewerController, type: :controller do
  include CurrentLanding
  let!(:landing) { create :landing }
  let!(:variant) { landing.default_variant }

  before do
    set_current_variant variant
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show
      expect(response.status).to eq 200
    end
  end
end
