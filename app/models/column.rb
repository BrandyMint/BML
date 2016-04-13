# Альтернативное название Column
#
class Column < ActiveRecord::Base
  belongs_to :collection

  before_save :set_title

  scope :ordered, -> { order :id }

  before_update :rename_column_in_data

  def self.upsert(fields)
    time = Time.zone.now
    record = new fields.reverse_merge(created_at: time, updated_at: time)
    payload = record.attributes.except('id', 'uuid')
    values = payload.values.map { |v| "'#{v}'" }
    connection.execute "INSERT INTO #{table_name} (#{payload.keys.join(', ')}) VALUES (#{values.join(', ')}) ON CONFLICT DO NOTHING"
  end

  def to_s
    title
  end

  def input_type
    if key.to_s.starts_with? 'is_'
      :boolean
    else
      :string
    end
  end

  private

  def set_title
    self.title = key unless title.present?
  end

  def rename_column_in_data
    return unless key_changed?
    RenameColumnInData.new(collection_id: collection_id, column_was: key_was, column_new: key).perform
  end
end
