require 'http_logger'

HttpLogger.logger = Rails.logger
HttpLogger.colorize = false

if Rails.env.production?
  HttpLogger.log_headers = true
  HttpLogger.log_request_body  = true  # Default: true
  HttpLogger.log_response_body = true  # Default: true
  HttpLogger.ignore = [/newrelic\.com|bugsnag|localhost|127.0.0.1/]
elsif Rails.env.test?
  HttpLogger.logger = Rails.logger
  HttpLogger.log_headers = true
  HttpLogger.log_request_body  = true  # Default: true
  HttpLogger.log_response_body = true  # Default: true
  HttpLogger.ignore = [/newrelic\.com|bugsnag|localhost|127.0.0.1/]
else
  HttpLogger.log_headers       = true  # Default: false
  HttpLogger.log_request_body  = true  # Default: true
  HttpLogger.log_response_body = true  # Default: true
  HttpLogger.ignore = [/newrelic\.com|bugsnag/]
end
