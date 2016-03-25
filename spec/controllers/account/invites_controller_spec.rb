require 'rails_helper'

RSpec.describe Account::InvitesController, type: :controller do
  include AccountControllerSupport

  let(:invite) { create :invite, account: account, user_inviter: user }

  describe 'POST create' do
    before :each do
      allow_any_instance_of(InviteMailer).to receive(:added_to_account)
    end

    context 'Invite existent user' do
      let!(:invited_user) { create :user }
      let(:invite_params) { { phone: invited_user.phone, role: :master } }
      it do
        post :create, invite: invite_params
        expect(response.status).to eq 302
      end
    end

    context 'Invite new user' do
      context 'by phone' do
        let(:invite_params) { { phone: '+79033891228', role: :master } }
        it 'redirects' do
          expect_any_instance_of(Invite).to receive :save!
          post :create, invite: invite_params
          expect(response.status).to eq 302
        end
      end

      context 'by email' do
        let(:invite_params) { { email: 'email@aaa.ru', role: :master } }
        it 'redirects' do
          expect_any_instance_of(Invite).to receive :save!
          post :create, invite: invite_params
          expect(response.status).to eq 302
        end
      end
    end
  end

  describe 'DELETE destroy' do
    it 'redirects' do
      expect_any_instance_of(Invite).to receive :destroy!
      delete :destroy, id: invite.id
      expect(response.status).to eq 302
    end
  end
end
