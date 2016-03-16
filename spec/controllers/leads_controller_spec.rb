require 'rails_helper'

RSpec.describe LeadsController, type: :controller do
  let!(:landing) { create :landing }
  let(:email) { 'some@email.ru' }
  let(:name) { 'somename' }
  let(:form) { { email: email, name: name, variant_uuid: landing.default_variant.uuid } }

  context 'create' do
    it do
      expect(controller).to receive(:create_lead)
      expect(controller).to receive(:send_notifications)
      post :create, form, subdomain: ''
    end
  end
end
