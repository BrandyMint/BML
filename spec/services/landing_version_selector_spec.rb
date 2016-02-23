require 'rails_helper'

RSpec.describe LandingVersionSelector do
  let(:host) { account.host }
  let(:path) { 'lp1' }
  let(:session) { {} }
  let(:cookies) { double }
  let(:params) { {} }

  let!(:account) { create :account }

  subject { described_class.new(host: host, path: path, session: session, cookies: cookies, params: params) }

  describe '#account' do
    it { expect(subject.account).to eq account }
  end

  describe '#landing' do
    let!(:landing) { create :landing, account: account }
    let(:path) { landing.path }

    it { expect(subject.landing).to eq landing }
  end

  describe '#landing_version' do
    let!(:landing) { create :landing, account: account }
    let(:path) { landing.path }

    it { expect(subject.landing_version).to eq landing.default_version }
  end

  describe '#landing_version (default)' do
    let!(:landing) { create :landing, account: account }
    let(:path) { '' }

    it { expect(subject.landing_version).to eq landing.default_version }
  end
end
