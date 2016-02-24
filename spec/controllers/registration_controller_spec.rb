require 'rails_helper'

describe RegistrationController, type: :controller do
  include SystemControllerSupport

  let!(:user_attrs) { attributes_for :user }

  describe 'GET #new' do
    it 'must be success' do
      get :new, subdomain: ''
      expect(response.status).to eq 200
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'must redirect to root_url' do
        post :create, registration_form: user_attrs.slice(:name, :email, :phone, :password), subdomain: ''
        expect(response.status).to eq 302
      end
    end

    context 'with invalid params' do
      it 'must render users/new' do
        post :create, registration_form: { email: 1 }, subdomain: ''
        expect(response.status).to eq 200
      end
    end
  end
end
