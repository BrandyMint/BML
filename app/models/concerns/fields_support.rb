module FieldsSupport
  extend ActiveSupport::Concern

  included do
    after_create :create_collection_fields
  end

  def fields
    @_fields ||= RowFields.new data
  end

  private

  def create_collection_fields
    data.keys.reject { |k| k == 'cookie' }.each do |key|
      fields_holder.columns.upsert key: key, title: key
    end
  end
end
