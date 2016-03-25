require 'rails_helper'

describe UserMailer do
  let(:user) { create :user, reset_password_token: 123 }

  describe '#reset_password_email' do
    subject { described_class.reset_password_email user.id }

    it do
      expect(subject).to have_body_text user.email
    end
  end

  describe '#email_confirmation' do
    subject { described_class.email_confirmation user.id }

    it do
      expect(subject).to have_body_text user.name
    end
  end
end
