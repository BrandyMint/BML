class Account::EditorController < Landing::ApplicationController
  layout 'landing'

  def edit
    render locals: { landing_version: landing_version }
  end

  private

  def current_landing_version
    landing_version
  end

  def landing_version
    @_landing_version ||= find_landing_version
  end

  def find_landing_version
    if params[:version_id].present?
      current_landing.versions.find params[:version_id]
    else
      current_landing.default_version
    end
  end
end
