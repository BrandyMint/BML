module FieldsSupport
  extend ActiveSupport::Concern

  included do
    after_create :create_collection_fields
    before_save :generate_data_string
  end

  def data_fields
    @_data_fields ||= RowFields.new collection.columns, data
  end

  private

  def generate_data_string
    self.data_string = data.values.join(' ')
  end

  def create_collection_fields
    data.keys.reject { |k| k == 'cookie' }.each do |key|
      fields_holder.columns.upsert key: key, title: key
    end
  end
end
