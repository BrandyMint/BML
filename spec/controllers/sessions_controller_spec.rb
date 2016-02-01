require 'rails_helper'

describe SessionsController do
  describe '#new' do
    it 'must return success' do
      get :new
      expect(response.status).to eq 200
    end
  end

  describe '#create' do
    context 'with valid params' do
      let(:email) { FactoryGirl.generate(:user_email) }
      it 'must log in' do
        get :create, session_form: { email: email, password: 123 }
        expect(controller.current_user).to be_an_instance_of(User)
      end
    end

    context 'with invalid params' do
      it 'must not log in' do
        get :create, session_form: { email: 'a' }
        expect(controller.current_user).not_to be_an_instance_of(User)
      end
    end
  end

  describe '#destroy' do
    it 'must log out' do
      login_user
      get :destroy
      expect(controller.current_user).not_to be_an_instance_of(User)
    end
  end
end
