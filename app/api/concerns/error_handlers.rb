module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, rescue_subclasses: true do |e|
      Bugsnag.notify e unless e.is_a? ActiveRecord::RecordInvalid
      status = 500
      code = e.class.name.underscore

      # case e.class
      # when UserAuthenticator::InvalidPassword
      # status = 401
      # when Grape::PredefinedError
      # status = e.satus
      # code   = e.code
      # when Authority::SecurityViolation
      # status = 403
      # end

      # Tasty.log_error e, context: {status: status, code: code, message: e.message}
      Rails.logger.error "[#{status}, #{code}] #{e.message}"
      Rails.logger.error e.backtrace.join("\n")

      Rack::Response.new(
        [{
          response_code: status,
          error_code:    code,
          error:         e.message
        }.to_json],
        status,
        'Content-type' => 'application/json'
      ).finish
    end
  end
end
