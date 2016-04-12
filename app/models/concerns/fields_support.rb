module FieldsSupport
  extend ActiveSupport::Concern

  INTERNAL_FIELDABLE_ATTRIBUTES =
    TrackingSupport::UTM_FIELDS.map(&:to_s) +
    TrackingSupport::UTM_FIELDS.map { |a| "last_#{a}" } +
    TrackingSupport::UTM_FIELDS.map { |a| "first_#{a}" }

  included do
    after_create :create_collection_fields
  end

  def fields
    @_fields ||= RowFields.new collection.columns, fields_data
  end

  def data_fields
    @_data_fields ||= RowFields.new collection.columns, data
  end

  def tracking_fields
    @_tracking_fields ||= RowFields.new collection.columns, tracking_attributes
  end

  private

  def fields_data
    data.merge tracking_attributes
  end

  def tracking_attributes
    attributes.slice(*INTERNAL_FIELDABLE_ATTRIBUTES)
  end

  def create_collection_fields
    data.keys.reject { |k| k == 'cookie' }.each do |key|
      fields_holder.columns.upsert key: key, title: key
    end
  end
end
