require 'rails_helper'

RSpec.describe Account::LeadsController, type: :controller do
  include SystemControllerSupport
  include Sorcery::TestHelpers::Rails::Integration
  include Sorcery::TestHelpers::Rails::Controller

  let!(:user) { create :user, :with_account }
  let(:account) { user.accounts.first }

  let!(:landing) { create :landing, account: account }

  context 'без аккаунта не должно пускать' do
    it 'returns http success' do
      get :index, landing_id: landing.id
      expect(response.status).to eq 401
    end
  end

  context 'с аккаунтом' do
    before(:each) do
      login_user user, login_url
      controller.send 'current_account=', account
    end

    it 'returns http success' do
      get :index, landing_id: landing.id
      expect(response.status).to eq 200
    end

    let(:lead) { create :lead, landing: landing }

    it 'returns http success' do
      get :show, landing_id: landing.id, id: lead.id
      expect(response.status).to eq 200
    end
  end
end
