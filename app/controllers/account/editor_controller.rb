class Account::EditorController < Account::BaseController
  layout 'editor'

  helper_method :current_variant

  before_action do
    raise NoCurrentVariant unless current_variant.present?
  end

  def show
  end

  private

  def current_variant
    @_variant ||= current_account.variants.find_by_uuid(params[:uuid])
  end
end
