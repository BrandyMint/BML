require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  include AccountControllerSupport
  include Sorcery::TestHelpers::Rails::Integration
  include Sorcery::TestHelpers::Rails::Controller

  before(:each) do
    login_user user, login_url
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe 'GET #select' do
    it 'НЕ существующий аккаунт' do
      get :select, id: 900
      expect(response.status).to eq 404
    end

    it 'существующий аккаунт' do
      get :select, id: account.id
      expect(response.status).to eq 302
    end
  end
end
