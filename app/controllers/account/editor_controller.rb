class Account::EditorController < Account::BaseController
  layout 'editor'

  helper_method :variant

  def show
  end

  private

  def variant
    @_variant ||= current_account.variants.find_by_uuid(params[:uuid])
  end
end
