require 'rails_helper'

RSpec.describe AttachClient do
  subject do
    described_class.new(lead: lead).call
  end

  describe 'Пустая заявка' do
    let!(:lead) { create :lead }

    it 'с пустой заявкой клиента не создаем' do
      expect(subject).to be_a NilClass
    end
  end

  describe 'Пустая заявка' do
    let(:email) { generate :user_email }
    let!(:lead) { create :lead, data: { email: email } }

    it 'создается клиент' do
      expect(subject).to be_a Client
      expect(subject.email).to eq email
    end
  end
end
