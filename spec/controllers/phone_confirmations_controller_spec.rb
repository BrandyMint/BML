require 'rails_helper'

RSpec.describe PhoneConfirmationsController, type: :controller do
  include SystemControllerSupport

  let!(:user) { create :user }
  let!(:phone) { generate :phone }

  context '#new' do
    it do
      get :new, phone: phone, use_route: :new_phone_confirmation
      expect(response).to be_ok
    end
  end

  context '#new phone confirmed' do
    let(:phone_confirmation) { create :phone_confirmation, :confirmed, user: user }
    let(:backurl) { 'http://backurl' }

    it 'если телефон уже подтвержден кидаем на backurl' do
      get :new, phone: phone_confirmation.phone, backurl: backurl, use_route: :new_phone_confirmation
      expect(response).to be_redirection
      expect(response.redirect_url).to eq backurl + "?confirmed_phone=#{CGI.escape phone_confirmation.phone}"
    end
  end

  context '#create' do
    it 'Мы не принимаем deliver_pin_code потому что оператор только что создан и ему уже отправляли pin_code' do
      expect_any_instance_of(PhoneConfirmation).to_not receive :deliver_pin_code!
      post :create, phone: user.phone, use_route: :phone_confirmation
      expect(response).to be_ok
    end

    it do
      expect_any_instance_of(PhoneConfirmation).to receive(:deliver_pin_code)
      post :create, phone: phone, use_route: :phone_confirmation
      expect(response).to be_ok
    end
  end

  context '#edit' do
    it do
      put :edit, phone_confirmation_form: { phone: phone, pin_code: 123 }, use_route: :phone_confirmation
      expect(response).to be_ok
    end
  end

  context '#update' do
    let(:phone_confirmation) { create :phone_confirmation, :confirmed, user: user }
    it do
      put :update,
        phone_confirmation_form: { phone: phone_confirmation.phone, pin_code: phone_confirmation.pin_code },
        use_route: :phone_confirmation
      expect(response).to be_redirection
      expect(phone_confirmation.reload).to be_is_confirmed
    end
  end
end
