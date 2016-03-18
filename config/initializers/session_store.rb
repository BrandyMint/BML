# Be sure to restart your server when you modify this file.

# Rails.application.config.session_store :cookie_store, key: '_bml_session', domain: :all

redis = Secrets.redis.try(:symbolize_keys) || {}

Rails.application.config.session_store(
  :redis_session_store,
  key: '_landos_session',
  domain: :all,
  tld_length: 2,

  on_redis_down: ->(e, env, sid) { Bugsnag.notify e, metaData: { env: env, sid: sid } },
  on_session_load_error: -> (e, sid) { Bugsnag.notify e, metaData: { sid: sid } },

  redis: redis.merge(key_prefix: 'bml:session:')
)
