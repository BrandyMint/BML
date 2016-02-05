require 'rails_helper'

RSpec.describe PhoneConfirmationsController, type: :controller do
  include SystemControllerSupport

  let!(:user) { create :user }
  let!(:phone) { generate :user_phone }

  context 'GET #new' do
    it do
      get :new, phone: phone
      expect(response).to be_ok
    end
  end

  context 'GET #new phone confirmed' do
    let(:phone_confirmation) { create :phone_confirmation, :confirmed, user: user }
    let(:backurl) { 'http://backurl' }

    it 'если телефон уже подтвержден кидаем на backurl' do
      get :new, phone: phone_confirmation.phone, backurl: backurl
      expect(response).to be_redirection
      expect(response.redirect_url).to eq backurl + "?confirmed_phone=#{CGI.escape phone_confirmation.phone}"
    end
  end

  context 'POST #create' do
    it 'Мы не принимаем deliver_pin_code потому что user только что создан и ему уже отправляли pin_code' do
      expect_any_instance_of(PhoneConfirmation).to_not receive :deliver_pin_code!
      post :create, phone: user.phone
      expect(response).to be_ok
    end

    it do
      expect_any_instance_of(PhoneConfirmation).to receive(:deliver_pin_code)
      post :create, phone: phone
      expect(response).to be_ok
    end
  end

  context 'GET #edit' do
    it do
      get :edit, phone_confirmation_form: { phone: phone, pin_code: 123 }
      expect(response).to be_ok
    end
  end

  context 'PATCH #update' do
    let(:phone_confirmation) { create :phone_confirmation, :confirmed, user: user }
    it do
      patch :update,
        phone_confirmation_form: { phone: phone_confirmation.phone, pin_code: phone_confirmation.pin_code }
      expect(response).to be_redirection
      expect(phone_confirmation.reload).to be_is_confirmed
    end
  end
end
