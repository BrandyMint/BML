require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  let(:url) { 'http://asdsdsadsa.asdsada/ru' }

  it do
    short_url = described_class.short! url
    expect(short_url).to be_a String

    expect(described_class.find_short(short_url)).to eq url
  end

  it do
    result = described_class.short_url(url)
    expect(result).to include AppSettings.host
  end

  it do
    short_url1 = described_class.short! url
    short_url2 = described_class.short! url
    expect(short_url1).to eq short_url2
  end
end
