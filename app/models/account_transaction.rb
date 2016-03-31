class AccountTransaction
  delegate :created_at, :details, :meta, :key, to: :raw_transaction

  def initialize(billing_account, raw_transaction)
    @billing_account = billing_account
    @raw_transaction = raw_transaction
  end

  def incoming?
    raw_transaction.to_account_id == billing_account.id
  end

  def amount
    incoming? ? raw_transaction.amount : -raw_transaction.amount
  end

  def period
    month_name = months[month.month]
    year = month.year
    "#{month_name} #{year}"
  rescue
    '-'
  end

  def tariff
    @tariff ||= Tariff.find tariff_id
  end

  private

  attr_reader :billing_account, :raw_transaction

  def month
    Date.parse meta['month']
  end

  def months
    I18n.t :'date.standalone_month_names'
  end

  def tariff_id
    meta['tariff_id']
  end
end
