class Landing::CollectionsController < Landing::BaseController
  layout 'landing_settings'

  def index
    render locals: { collections: current_landing.collections }
  end

  def edit
    render locals: { collection: collection }
  end

  def show
    redirect_to landing_collections_path(current_landing)
  end

  def new
    render locals: { collection: current_account.collections.build }
  end

  def create
    current_landing.collections.create! permitted_params
    redirect_to landing_collections_path(current_landing),
                flash: { success: I18n.t('flashes.collections.created') }
  rescue ActiveRecord::RecordInvalid => err
    render 'new', locals: { collection: err.record }, flash: { error: err.message }
  end

  def update
    collection.update! permitted_params
    redirect_to landing_collections_path(current_landing),
                flash: { success: I18n.t('flashes.collections.saved') }
  rescue ActiveRecord::RecordInvalid => err
    render 'edit', locals: { collection: err.record }, flash: { error: err.message }
  end

  private

  def collection
    current_account.collections.find params[:id]
  end

  def permitted_params
    params.require(:collection).permit(:title)
  end
end
