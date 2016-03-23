require 'rails_helper'

RSpec.describe Account::MembersController, type: :controller do
  include AccountControllerSupport

  let(:member) { create :membership, account: account }

  describe 'GET index' do
    it 'returns http success' do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe 'GET edit' do
    it 'returns http success' do
      get :edit, id: member.id
      expect(response.status).to eq 200
    end
  end

  describe 'PATCH update' do
    it 'redirects' do
      patch :update, id: member.id, membership: { sms_notification: true }
      expect(response.status).to eq 302
    end
  end

  describe 'DELETE destroy' do
    before { member.update_column :role, :master }
    it 'redirects' do
      expect_any_instance_of(Membership).to receive :destroy!
      delete :destroy, id: member.id
      expect(response.status).to eq 302
    end
  end

  describe 'POST send_email_confirmation' do
    it 'must send confirmation email' do
      allow(member.user).to receive(:deliver_email_confirmation!)
      post :send_email_confirmation, id: member.id
      expect(response.status).to eq 302
    end
  end
end
