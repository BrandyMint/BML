module ApiSession
  extend ActiveSupport::Concern

  included do
    helpers do
      def session
        # Избавляемся от #<ActionDispatch::Request::Session:0x7fc878b35400 not yet loaded>
        env[Rack::Session::Abstract::ENV_SESSION_KEY][:init] = true

        return env[Rack::Session::Abstract::ENV_SESSION_KEY]

        # тестах могут не указывать rack_env и соответсвенно env пустой
      rescue => e
        Bugsnag.notify e
        {}
      end
    end
  end
end
