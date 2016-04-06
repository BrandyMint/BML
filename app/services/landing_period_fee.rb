# Расчет суммы абонплаты в месяц для одного лендинга
# Используется в стратегии PerLandingFeeStrategy
class LandingPeriodFee
  include Virtus.model(strict: true, nullify_blank: true)
  include MoneyRails::ActionViewExtension

  attribute :landing, Landing
  attribute :price, Money
  attribute :month, Date

  delegate :used_days, :period_days, :ratio, to: :used_period

  def call
    FeeResult.new total: total,
                  description: description
  end

  private

  def total
    @_total ||= price * ratio
  end

  def description
    I18n.t(
      'services.landing_period_fee.description',
      landing: landing,
      used_days: used_days,
      period_days: I18n.t('days_count_genitive', count: period_days),
      total: humanized_money_with_symbol(total)
    )
  end

  def used_period
    @_used_period ||= UsedPeriod.new(start_date: landing.created_at.to_date, period: month).call
  end
end
