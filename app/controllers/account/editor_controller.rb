class Account::EditorController < Account::BaseController
  layout 'editor'

  helper_method :current_variant

  def show
  end

  private

  def current_variant
    @_variant ||= current_account.variants.find_by_uuid(params[:uuid])
  end
end
