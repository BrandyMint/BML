class UsedPeriod
  include Virtus.model(strict: true, nullify_blank: true)

  attribute :start_date, Date
  attribute :period, Date

  def call
    UsedPeriodResult.new ratio: (used_days.to_f / period_days.to_f).round(2),
                         used_days: used_days,
                         period_days: period_days
  end

  private

  def used_days
    if first_period?
      (period_days - start_date.day) + 1
    elsif full_period?
      period_days
    else
      0
    end
  end

  def period_days
    Time.days_in_month period.month, period.year
  end

  def first_period?
    month(period) == month(start_date)
  end

  def full_period?
    month(period) > month(start_date)
  end

  def month(date)
    date.beginning_of_month
  end
end
