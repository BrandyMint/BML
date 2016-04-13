require 'rails_helper'

describe BalanceMailer do
  describe '#charge_error_email' do
    let(:user) { create :user, :with_account }
    let(:account) { user.accounts.last }
    let(:date) { Date.current }
    subject { described_class.charge_error_email account.id, date.year, date.month }

    before do
      default_url_options[:host] = 'example.com'
      default_url_options[:port] = 3000
    end

    it do
      expect(subject).to have_body_text account.to_s
      expect(subject).to have_body_text I18n.l(date, format: :month)
      expect(subject).to have_body_text new_account_payment_url
      expect(subject).to have_body_text account_billing_url
    end
  end
end
