require 'rails_helper'

describe RegistrationController do
  let!(:user_attrs) { FactoryGirl.attributes_for :user }

  describe '#new' do
    it 'must be success' do
      get :new
      expect(response.status).to eq 200
    end
  end

  describe '#create' do
    context 'with valid params' do
      it 'must redirect to root_url' do
        post :create, registration_form: user_attrs.slice(:name, :email, :phone, :password)
        expect(response.status).to eq 302
      end
    end

    context 'with invalid params' do
      it 'must render users/new' do
        post :create, registration_form: { email: 1 }
        expect(response.status).to eq 200
      end
    end
  end
end
