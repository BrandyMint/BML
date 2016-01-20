class Account::SettingsController < Landing::ApplicationController
  layout 'settings'

  def show
    render locals: { settings: settings }
  end

  private

  def settings
    LandingSettings.new
  end
end
