require 'sidekiq'
require 'sidekiq-status'
# CONFIG_FILE = './config/crontab.yml'

if Rails.env.production?
  Sidekiq.configure_server do |config|
    # Sidekiq::Logging.logger = LoggerCreator.build :sidekiq
    config.redis = Secrets.sidekiq.redis.symbolize_keys
    config.error_handlers << proc { |ex, context| Bugsnag.notify(ex, context) }
    config.failures_max_count = 50_000
    config.failures_default_mode = :exhausted
    config.server_middleware do |chain|
      chain.add Sidekiq::Status::ServerMiddleware, expiration: 180.minutes
    end
    config.client_middleware do |chain|
      chain.add Sidekiq::Status::ClientMiddleware
    end

    # Sidekiq::Cron::Job.load_from_hash YAML.load_file(CONFIG_FILE)
  end

  Sidekiq.configure_client do |config|
    config.redis = Secrets.sidekiq.redis.symbolize_keys

    config.client_middleware do |chain|
      chain.add Sidekiq::Status::ClientMiddleware
    end
  end
end

Sidekiq.default_worker_options = { 'backtrace' => true }

if Rails.env.development? || Rails.env.reproduction? || Rails.env.staging?
  require 'sidekiq/testing/inline'
  Sidekiq::Testing.inline!
end
