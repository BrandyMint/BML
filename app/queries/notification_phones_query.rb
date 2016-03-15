class NotificationPhonesQuery
  include Virtus.model

  attribute :account_id, Integer

  def call
    PlainSQLQuery.execute_query(sql).values.flatten
  end

  private

  def sql
    [
      %(
        SELECT DISTINCT u.phone FROM users u
        JOIN memberships m ON m.user_id = u.id
        JOIN accounts a ON a.id = m.account_id
        WHERE a.id = ?
          AND u.phone_confirmed_at IS NOT NULL
          AND u.phone IS NOT NULL
          AND u.phone != ''
          AND m.sms_notification = 't'
      ),
      account_id
    ]
  end
end
