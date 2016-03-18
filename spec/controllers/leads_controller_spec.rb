require 'rails_helper'

RSpec.describe LeadsController, type: :controller do
  let!(:account)     { create :account }
  let!(:landing)     { create :landing, account: account }
  let(:email)        { 'some@email.ru' }
  let(:name)         { 'somename' }
  let(:phone)        { '+79033891228' }
  let(:variant)      { landing.default_variant }
  let(:variant_uuid) { variant.uuid }
  let(:form)         { { email: email, name: name, phone: phone, variant_uuid: variant_uuid } }

  before do
    user = create :user, :confirmed
    user.memberships.create! account_id: account.id, role: :owner
    self.use_transactional_fixtures = false
    Lead.delete_all
  end

  context 'create' do
    it do
      expect(SmsWorker).to receive(:perform_async)

      delay = double
      expect(delay).to receive(:new_lead_email)
      expect(LeadMailer).to receive(:delay).and_return(delay)

      post :create, form, subdomain: ''

      expect(Lead.count).to eq 1

      lead = Lead.first
      expect(lead.name).to eq name
      expect(lead.email).to eq email
      expect(lead.phone).to eq phone
      expect(lead.variant_id).to eq variant.id
    end
  end
end
