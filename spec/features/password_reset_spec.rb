require 'rails_helper'

RSpec.feature 'Password reset', type: :feature do
  let!(:user) { create :user, :with_account }

  background do
    Capybara.app_host = AppSettings.host

    create :account, :root
  end

  scenario 'by email' do
    expect(user.reset_password_token).to be_falsy

    visit_reset_password

    expect(UserMailer).to receive(:send_mail_with_worker)

    submit_form user.email

    expect(user.reload.reset_password_token).to be_truthy
    expect(page.html.include?(I18n.t('flashes.password_reset.created'))).to be_truthy
  end

  scenario 'by sms' do
    old_password = user.crypted_password

    visit_reset_password

    expect(SmsWorker).to receive(:perform_async)

    submit_form user.phone

    expect(user.reload.crypted_password).not_to eq old_password
    expect(page.html.include?(I18n.t('flashes.password_reset.created'))).to be_truthy
  end

  def visit_reset_password
    visit new_password_reset_path
    expect(current_path).to eq new_password_reset_path
  end

  def submit_form(login)
    within 'form.reset_password' do
      fill_in 'reset_password[login]', with: login
      click_button I18n.t('buttons.restore')
    end
  end
end
