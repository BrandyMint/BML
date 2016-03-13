class AppSettings
  include Singleton

  ATTRIBUTES = %i(title default_domain)

  def self.current
    instance
  end

  class << self
    delegate *ATTRIBUTES, to: :current
  end

  delegate *ATTRIBUTES, to: :settings

  private

  def settings
    Settings.app
  end
end
