class Landing::ColumnsController < Landing::BaseController
  layout 'landing_settings'

  def index
    authorize Column

    render locals: {
      collection: collection,
      columns: collection.columns.ordered
    }
  end

  def edit
    authorize column

    render locals: { column: column, collection: collection }
  end

  def new
    authorize Column

    render locals: { column: collection.columns.build, collection: collection }
  end

  def create
    authorize Column

    collection.columns.create! permitted_params
    success_redirect
  rescue ActiveRecord::RecordInvalid => err
    render 'new', locals: { column: err.record }, flash: { error: err.message }
  end

  def update
    authorize column

    column.update! permitted_params

    success_redirect
  rescue ActiveRecord::RecordInvalid => err
    render 'edit', locals: { column: err.record }, flash: { error: err.message }
  end

  def destroy
    authorize column

    column.destroy!
    redirect_to :back
  end

  private

  def success_redirect
    redirect_to landing_collection_columns_path(current_landing, collection),
                flash: { success: I18n.t('flashes.columns.saved') }
  end

  def collection
    current_account.collections.find params[:collection_id]
  end

  def column
    collection.columns.find params[:id]
  end

  def permitted_params
    params.require(:column).permit(:title, :key)
  end
end
