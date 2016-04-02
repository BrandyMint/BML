require 'rails_helper'

RSpec.describe RowFields do
  let(:data) { { a: 1 } }

  subject { RowFields.new data }

  it { expect(subject[:a]).to be_a LeadField }
  it { expect(subject.count).to eq 1 }
end
