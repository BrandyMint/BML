# Альтернативное название Column
#

class CollectionField < ActiveRecord::Base
  belongs_to :collection

  before_save :set_title

  scope :ordered, -> { order :id }

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

  private

  def set_title
    self.title = key unless title.present?
  end
end
