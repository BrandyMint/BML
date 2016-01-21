module CurrentLanding
  NoCurrentLandingVersion = Class.new StandardError

  def current_landing_version
    if Thread.current[:landing_version].present?
      Thread.current[:landing_version]
    else
      fail NoCurrentLandingVersion
    end
  end

  def set_current_landing_version(landing_version)
    Thread.current[:landing_version] = landing_version
    set_current_account landing_version.account
  end

  def safe_current_landing_version
    current_landing_version
  rescue NoCurrentLandingVersion
    nil
  end
end
