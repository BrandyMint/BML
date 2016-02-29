class Account::EditorController < Account::BaseController
  layout 'editor'

  helper_method :landing_version

  def show
  end

  private

  def landing_version
    @_landing_version ||= current_account.versions.find_by_uuid(params[:uuid])
  end
end
