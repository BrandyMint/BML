require 'rails_helper'

RSpec.describe Account::EditorController, type: :controller do
  include SystemControllerSupport
  include Sorcery::TestHelpers::Rails::Integration
  include Sorcery::TestHelpers::Rails::Controller

  let!(:user) { create :user, :with_account }
  let(:account) { user.accounts.first }

  before(:each) do
    login_user user, login_url
    controller.send :set_current_account, account
  end

  let!(:landing) { create :landing, account: account }

  describe 'GET #show' do
    it 'returns http success' do
      get :show, uuid: landing.default_version.uuid
      expect(response.status).to eq 200
    end
  end
end
