class TariffMonth < ActiveRecord::Base
  AVAILABLE_UPDATE_TARIFF_IN_CURRENT_MONTH = false

  belongs_to :account
  belongs_to :tariff

  before_validation :define_dates
  before_save :define_dates

  scope :ordered, -> { order 'beginning_of_month desc' }
  scope :for_date, -> (date) { where 'beginning_of_month <=? and end_of_month >=?', date, date }
  scope :nearest_to, -> (date) { where('end_of_month <=?', date).ordered }

  validates :beginning_of_month,
            presence: true,
            uniqueness: { scope: [:account_id, :tariff_id] }
  validates :end_of_month,
            presence: true,
            uniqueness: { scope: [:account_id, :tariff_id] }

  before_update :disable_update

  delegate :include?, to: :range

  def month
    beginning_of_month
  end

  def month=(date)
    self.beginning_of_month = date
    define_dates

    beginning_of_month
  end

  private

  def range
    Range.new beginning_of_month, end_of_month
  end

  def disable_update
    raise 'Can`t update dates' if beginning_of_month_changed? || end_of_month_changed?

    return if AVAILABLE_UPDATE_TARIFF_IN_CURRENT_MONTH

    raise 'Can`t update tariff in current month' if beginning_of_month <= Time.zone.today
  end

  def define_dates
    raise 'No beginning_of_month is defined' unless beginning_of_month.present?
    self.beginning_of_month = beginning_of_month.beginning_of_month
    self.end_of_month = beginning_of_month.end_of_month
  end
end
