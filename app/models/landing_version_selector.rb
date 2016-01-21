class LandingVersionSelector
  def initialize(host:, session:, params:, cookies: )
    @host    = host
    @session = session
    @cookies = cookies
    @params  = params
  end

  def landing_version
    return nil unless subdomain.present?

    version = param_version || session_version || calculate_version

    session[:version_id] = version.id

    version
  end

  private

  attr_reader :host, :cookies, :params, :session

  def subdomain
    @_subdomain ||= Subdomain.find_by_current_domain host
  end

  def session_version
    return nil unless session[:version_id].present?
    active_versions.find session[:version_id]
  end

  def param_version
    return nil unless params[:version_id].present?
    active_versions.find params[:version_id]
  end

  def calculate_version
    active_versions.active.sample
  end

  def active_versions
    subdomain.landing.versions.active
  end
end
