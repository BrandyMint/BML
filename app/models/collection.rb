class Collection < ActiveRecord::Base
  belongs_to :landing
  has_many :leads, dependent: :delete_all
  has_many :fields, dependent: :delete_all, class_name: 'CollectionField'

  scope :ordered, -> { order :id }

  def to_s
    "Коллекция #{created_at}"
  end

  def last_lead_at
    @_last_lead_at ||= leads.ordered.last.try(:created_at)
  end
end
