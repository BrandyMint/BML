class TouchOrCreateViewer
  include Virtus.model(strict: true)

  attribute :viewer_uid, String
  attribute :landing_id, Integer
  attribute :remote_ip,  String
  attribute :user_agent, String

  def call
    ActiveRecord::Base.connection.execute(
      ActiveRecord::Base.send(
        :sanitize_sql_array,
        sql_array
      )
    )
  end

  private

  def sql_array
    [
      "INSERT INTO viewers (landing_id, uid, remote_ip, user_agent, created_at, updated_at)
      VALUES (?, ?, ?, ?, current_timestamp, current_timestamp)
      ON CONFLICT (landing_id, uid) DO UPDATE SET updated_at = statement_timestamp()",
      landing_id,
      viewer_uid,
      remote_ip,
      user_agent
    ]
  end
end
