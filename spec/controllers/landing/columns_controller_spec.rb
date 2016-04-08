require 'rails_helper'

RSpec.describe Landing::ColumnsController, type: :controller do
  include AccountControllerSupport

  let!(:landing) { create :landing, :with_variant, :with_collection, account: account }
  let(:collection) { landing.collections.first }
  let(:column) { collection.columns.first }

  it 'returns http success' do
    get :index, landing_id: landing.id, collection_id: collection.id
    expect(response.status).to eq 200
  end

  it 'returns http success' do
    get :edit, landing_id: landing.id, collection_id: collection.id, id: column.id
    expect(response.status).to eq 200
  end

  it 'returns http success' do
    get :new, landing_id: landing.id, collection_id: collection.id
    expect(response.status).to eq 200
  end

  it 'redirects' do
    post :create, landing_id: landing.id, collection_id: collection.id, column: { key: :a, title: :b }
    expect(response.status).to eq 302
  end

  it 'redirects' do
    delete :destroy, landing_id: landing.id, collection_id: collection.id, id: column.id
    expect(response.status).to eq 302
  end
end
