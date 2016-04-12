require 'rails_helper'

RSpec.describe Account::PaymentsController, type: :controller do
  include AccountControllerSupport

  describe 'GET new' do
    it 'returns http success' do
      get :new
      expect(response.status).to eq 302
    end
  end
end
