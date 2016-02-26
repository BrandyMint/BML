class Account::SettingsController < Landing::BaseController
  layout 'settings'

  def show
    render locals: { settings: settings }
  end

  private

  def settings
    current_landing
    # LandingSettings.new
  end

  def permitted_params
    params.require(:landing).permit(:title)
  end
end
