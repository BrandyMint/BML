require 'rails_helper'

RSpec.describe RowFields do
  let!(:collection) { create :collection, :with_columns }
  let(:data) { { a: 1 } }

  subject { RowFields.new collection.columns, data }

  it { expect(subject[:a]).to be_a LeadField }
  it { expect(subject.count).to eq 1 }
end
