class Account::CollectionsController < Landing::ApplicationController
  layout 'landing'

  def index
    render locals: { collections: current_landing.collections, form: form, fields: fields, items: items }
  end

  private

  def fields
    collection.fields.ordered
  end

  def items
    collection.items.page(params[:page]).per(20)
  end

  def collection
    current_landing.collections.first
  end

  def form
    (params[:form] || 1).to_i
  end
end
