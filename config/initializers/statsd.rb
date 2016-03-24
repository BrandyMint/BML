require 'statsd'

if Secrets.statsd.present? && (Rails.env.development? || Rails.env.production?)
  $statsd = Statsd.new Secrets.statsd.host, Secrets.statsd.port

  # ActiveSupport::Notifications.subscribe /performance/ do |name, _start, _finish, _id, payload|
  # StatsdIntegration.send_event_to_statsd(name, payload)
  # end

  require 'nunes'

  Nunes.subscribe $statsd

  StatsD.backend = StatsD::Instrument::Backends::UDPBackend.new "#{Secrets.statsd.host}:#{Secrets.statsd.port}", :statsd
  StatsD.prefix = 'bml.app'

  if Rails.env.production?
    # Sample 10% of events. By default all events are reported, which may overload your network or server.
    # You can, and should vary this on a per metric basis, depending on frequency and accuracy requirements
    # StatsD.default_sample_rate = (ENV['STATSD_SAMPLE_RATE'] || 0.1 ).to_f
    Sidekiq.configure_server do |config|
      config.server_middleware do |chain|
        chain.add Sidekiq::Statsd::ServerMiddleware, env: Rails.env, prefix: 'worker', host: Secrets.statsd.host, port: Secrets.statsd.port
      end
    end
  end
else
  StatsD.backend = StatsD::Instrument::Backends::LoggerBackend.new(Rails.logger)
end
