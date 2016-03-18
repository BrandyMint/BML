Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?

  OmniAuth.config.full_host = proc { |_env| AppSettings.host }

  if Secrets.yandex.present?
    provider :yandex, Secrets.yandex.id, Secrets.yandex.secret
  end

  twitter = {
    consumer_key:    'pydwshLRVa3191JZtCHnGcfFR',
    consumer_secret: '9DJGq7sBDt9k8SSm6PYTZoYxusRreM5H56ymY8LgQ5rK5gaoeC'
  }

  provider :twitter, twitter[:consumer_key], twitter[:consumer_secret]
end
