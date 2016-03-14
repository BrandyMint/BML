# rubocop:disable Style/GlobalVars
# rubocop:disable Style/ConditionalAssignment

if Secrets.redis.present?
  $redis = Redis.new Secrets.redis.symbolize_keys || Secrets.sidekiq.redis.symbolize_keys
else
  $redis = Redis.new
end

$rollout = Rollout.new Redis::Namespace.new Rails.env + '_bml_features', redis: $redis
