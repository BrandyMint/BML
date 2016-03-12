class Viewer < ActiveRecord::Base
  has_many :views, class_name: 'LandingView', primary_key: :uid, foreign_key: :viewer_uid

  def self.touch_or_create(viewer_uid)
    sql = ActiveRecord::Base.send(
      :sanitize_sql_array,
      ["INSERT INTO viewers (uid, created_at, updated_at) VALUES (?, current_timestamp, current_timestamp) ON CONFLICT (uid) DO UPDATE SET updated_at = statement_timestamp()", viewer_uid ]
    )
    ActiveRecord::Base.connection.execute(sql)
  end
end
