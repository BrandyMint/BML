class UpsertTariffChange
  include Virtus.model(strict: true, nullify_blank: true)

  attribute :account, Account
  attribute :tariff, Tariff

  delegate :current_tariff, to: :account

  def call
    return if same_tariff?

    PlainSQLQuery.execute_query(sql)
  end

  private

  def sql
    [
      "INSERT INTO tariff_changes (account_id, from_tariff_id, to_tariff_id, activates_at, created_at, updated_at)
      VALUES (?, ?, ?, ?, current_timestamp, current_timestamp)
      ON CONFLICT (activates_at, account_id) DO UPDATE SET from_tariff_id = ?, to_tariff_id = ?, updated_at = statement_timestamp()",
      account.id,
      current_tariff.id,
      tariff.id,
      activates_at,
      current_tariff.id,
      tariff.id
    ]
  end

  def same_tariff?
    current_tariff == tariff
  end

  def activates_at
    time = Time.zone.today
    Time.zone.local time.year, time.next_month.month
  end
end
