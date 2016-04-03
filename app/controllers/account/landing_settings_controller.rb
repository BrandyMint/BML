class Account::LandingSettingsController < Landing::BaseController
  layout 'landing_settings'

  helper_method :current_landing

  def address
    render locals: { landing: current_landing }
  end

  def meta
    render locals: { landing: current_landing }
  end

  def direct
    render locals: { landing: current_landing }
  end

  def update
    current_landing.update_attributes! permitted_params
    redirect_to :back
  rescue ActiveRecord::RecordInvalid => err
    render subaction, locals: { landing: err.record }
  end

  private

  def subaction
    params[:subaction]
  end

  def current_landing
    raise 'No landing_id in param' unless params[:landing_id]
    @_current_landing ||= current_account.landings.find params[:landing_id]
  end

  def permitted_params
    params.require(:landing).permit(:title, :path, :head_title, :meta_keywords, :meta_description)
  end
end
