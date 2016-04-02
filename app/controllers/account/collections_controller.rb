class Account::CollectionsController < Landing::BaseController
  layout 'landing_settings'

  def index
    render locals: { collections: current_landing.collections }
  end

  def edit
    render locals: { collection: collection }
  end

  def show
    redirect_to account_landing_collections_path(current_landing)
  end

  def update
    collection.update! permitted_params
    redirect_to account_landing_collections_path(current_landing),
                flash: { success: I18n.t('flashes.collection.saved') }
  rescue ActiveRecord::RecordInvalid => err
    redirect_to :back, flash: { error: err.message }
  end

  private

  def collection
    current_account.collections.find params[:id]
  end

  def permitted_params
    params.require(:collection).permit(:title)
  end
end
