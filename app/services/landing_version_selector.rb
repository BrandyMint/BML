class LandingVersionSelector
  def initialize(host:, path:, session:, params:, cookies: )
    @host    = host
    @session = session
    @cookies = cookies
    @params  = params
    @path    = path
  end

  delegate :account, to: :subdomain, allow_nil: true

  def landing
    return unless account
    @_landing ||= account.landings.find_by_path(path) || account.default_landing
  end

  def landing_version
    return unless landing
    version = param_version || session_version || calculate_version

    session[:version_id] = version.id

    version
  end

  private

  attr_reader :host, :cookies, :params, :session, :path

  def subdomain
    # @_subdomain ||= Subdomain.find_by_current_domain host
    @_subdomain ||= Subdomain.find_by_subdomain host.split('.').first
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
    # TODO алгоритм выборки версии
    active_versions.active.sample
  end

  def active_versions
    landing.versions.active
  end
end
