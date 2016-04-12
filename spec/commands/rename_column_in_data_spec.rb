require 'rails_helper'

RSpec.describe RenameColumnInData do
  let(:collection) { create :collection }
  let!(:lead) { create :lead, collection: collection, data: { a: 1 } }

  it do
    described_class.new(collection_id: collection.id, column_was: :a, column_new: :b).perform

    expect(collection.leads.first.data).to match('b' => '1')
  end
end
