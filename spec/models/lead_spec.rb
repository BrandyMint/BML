require 'rails_helper'

RSpec.describe Lead, type: :model do
  let(:lead) { create :lead, data: { a: '1' } }

  it { expect(lead.data.a).to eq '1' }

  context '#delete_data_key' do
    before do
      lead.delete_data_key! :a
    end

    it { expect(lead.reload.data.keys).to be_empty }
  end
end
