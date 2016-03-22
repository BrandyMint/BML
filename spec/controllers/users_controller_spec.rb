require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#new' do
    let!(:invite) { create :invite }
    it 'без приглашения' do
      get :new
      expect(response.status).to eq 302
    end

    it 'с действующим приглашением' do
      get :new, invite_key: invite.key

      expect(response).to render_template :invite
      expect(response.status).to eq 200
    end

    it 'с просроченным приглашением' do
      get :new, invite_key: 'broken'
      expect(response.status).to eq 302
    end
  end

  describe '#create' do
    context 'без приглашения' do
      let(:user_params) { { name: 'Вася', email: 'danil@ggg.ru' } }
      it do
        get :create, user: user_params
        expect(response.status).to redirect_to account_root_url
        expect(User.find_by_email(user_params[:email])).to be_present
      end
    end

    context 'с приглашением и с другим емайлом' do
      let(:invite) { create :invite, email: generate(:invite_email), phone: nil }
      let(:email)  { generate :invite_email }
      let(:user_params) { { name: 'Вася', email: email } }

      it 'убеждаемся что у invite-а другой email' do
        expect(invite.email).to_not eq email
      end

      it do
        get :create, user: user_params, invite_key: invite.key
        expect(response.status).to redirect_to account_root_url
        expect(User.find_by_email(email)).to be_persisted
      end
    end

    context 'с ошибками' do
      let(:invite) { create :invite }
      let(:user_params) { { name: 'Вася' } }
      it do
        get :create, user: user_params
        expect(response.status).to eq 302
      end
    end
  end
end
