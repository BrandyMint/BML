class Account::LeadsController < Landing::BaseController
  layout 'leads'

  def index
    render locals: {
      collections: current_landing.collections,
      current_collection: current_collection,
      fields: fields,
      items: items
    }
  end

  private

  def fields
    current_collection.fields.ordered
  end

  def items
    paginate current_collection.items.ordered
  end

  def current_collection
    find_collection || current_landing.default_collection
  end

  def find_collection
    return nil unless params[:collection_id]

    current_landing.collections.find params[:collection_id]
  end
end
