require 'rails_helper'

RSpec.describe ViewerController, type: :controller do
  include CurrentLanding
  let!(:landing) { create :landing }
  let!(:landing_version) { landing.default_version }

  before do
    set_current_landing_version landing_version
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show
      expect(response.status).to eq 200
    end
  end
end
