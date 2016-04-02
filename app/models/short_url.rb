require 'securerandom'
class ShortUrl < ActiveRecord::Base
  def self.short!(url)
    sql = [
      "INSERT INTO #{table_name} (url, secret_key) VALUES (?, ?) ON CONFLICT (url) DO UPDATE set updated_at = ? RETURNING id, secret_key",
      url,
      SecureRandom.hex(4),
      Time.zone.now
    ]

    f = PlainSQLQuery.execute_query(sql).first

    raise "No result in shortenification! #{url}" unless f.present?

    f['id'] + '-' + f['secret_key']
  end

  def self.short_url(url)
    Rails.application.routes.url_helpers.short_url short!(url), host: AppSettings.host
  end

  def self.find_short(key)
    id, secret_key = key.split('-')
    model = find_by(id: id, secret_key: secret_key)
    return unless model

    model.url
  end
end
