class Collection < ActiveRecord::Base
  belongs_to :landing
  has_many :leads
  has_many :fields, class_name: 'CollectionField'

  scope :ordered, -> { order :id }

  def to_s
    "Коллекция #{created_at}"
  end

  def last_lead_at
    @_last_lead_at ||= leads.ordered.last.try(:created_at)
  end
end
