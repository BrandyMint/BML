require 'rails_helper'

RSpec.describe AttachClient do
  let!(:lead) { create :lead }

  subject do
    described_class.new(lead: lead).call
  end

  describe '#call' do
    it do
      expect(subject).to be_a Client
    end
  end
end
