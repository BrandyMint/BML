class AccountFeatures
  include Virtus.model

  attribute :account, Account
  attribute :tariff, Tariff

  def leads_limit
    return if active?
    tariff.blocked_leads_count
  end

  private

  def active?
    paid? || free_days_available? && free_leads_available?
  end

  def paid?
    true
  end

  def free_days_available?
    Time.zone.now < account.created_at + tariff.free_days_count.days
  end

  def free_leads_available?
    account.leads.count <= tariff.free_leads_count
  end
end
