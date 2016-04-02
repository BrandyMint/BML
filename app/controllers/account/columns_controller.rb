class Account::ColumnsController < Landing::BaseController
  layout 'account_settings'

  def index
    render locals: {
      collection: collection,
      columns: collection.columns
    }
  end

  def edit
    render locals: { column: column }
  end

  def update
    current_account.update! permitted_params
    redirect_to :back, flash: { success: I18n.t('flashes.column.saved') }

  rescue ActiveRecord::RecordInvalid => err
    redirect_to :back, flash: { error: err.message }
  end

  private

  def collection
    current_account.collections.find params[:collection_id]
  end

  def column
    collection.fields
  end

  def permitted_params
    params.require(:account).permit(:name)
  end
end
