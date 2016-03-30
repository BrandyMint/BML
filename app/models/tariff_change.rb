class TariffChange < ActiveRecord::Base
  include Archivable

  belongs_to :account
  belongs_to :from_tariff, class_name: 'Tariff'
  belongs_to :to_tariff, class_name: 'Tariff'

  scope :ordered, -> { order activates_at: :asc }
  scope :pending, lambda {
    alive.where('activates_at > current_timestamp').ordered
  }
  scope :for_change, lambda {
    alive.where('activates_at <= current_timestamp').ordered
  }
end
