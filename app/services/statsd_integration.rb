module StatsdIntegration
  def send_event_to_statsd(name, payload)
    action = payload[:action] || :increment
    measurement = payload[:measurement]
    value = payload[:value]
    key_name = "#{name.to_s.capitalize}.#{measurement}"
    batch = Statsd::Batch.new($statsd)
    batch.__send__ action.to_s, "production.#{key_name}", (value || 1)
    batch.__send__ action.to_s, "#{nodename}.#{key_name}", (value || 1)
    batch.flush
  end

  def nodename
    @nodename ||= Sys::Uname.nodename.gsub(/\./, '-')
  end
end
