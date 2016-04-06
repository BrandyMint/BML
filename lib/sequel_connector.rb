class SequelConnector
	def initialize
		# load_database_config
	end

	def connect_database
    Sequel.connect config.merge(loggers: loggers, adapter: adapter)
  end

	private

  def config
    Rails.application.config.database_configuration[Rails.env].symbolize_keys
  end

	# Sequel adapter name for PostgreSQL is postgres and for ActiveRecord is postgresql
	def adapter
		config[:adapter].sub('postgresql', 'postgres')
	end

	def loggers
		@env == 'development' ? [Logger.new($stdout)] : nil
	end
end
