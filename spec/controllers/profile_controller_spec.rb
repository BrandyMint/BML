require 'rails_helper'

RSpec.describe ProfileController, type: :controller do

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    it "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST send_email_confirmation' do
    it 'return http success' do
      allow(user).to receive(:deliver_email_confirmation!)
      post :send_email_confirmation #, subdomain: 'app'
      expect(response.status).to eq 302
    end
  end

  describe '#confirm_email' do
    let!(:user) { create :user, email: 'some@email.ru' }
    # before { user.send :require_email_confirmation }
    it 'must redirect' do
      expect_any_instance_of(Operator).to receive(:confirm_email!)
      get :confirm_email, token: user.email_confirm_token
      expect(response.status).to eq 302
    end
  end
end
