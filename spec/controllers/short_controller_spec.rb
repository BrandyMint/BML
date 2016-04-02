require 'rails_helper'

RSpec.describe ShortController, type: :controller do
  let(:url) { 'http://someurl.ru/' }
  let(:id) { ShortUrl.short! url }

  it 'redirects' do
    get :show, id: id
    expect(response).to have_http_status(:redirect)
    expect(response.redirect_url).to eq url
  end
end
