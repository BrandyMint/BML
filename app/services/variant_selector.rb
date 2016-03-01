class VariantSelector
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

  def variant
    return unless landing
    variant = param_variant || session_variant || calculate_variant

    session[:variant_id] = variant.id

    variant
  end

  private

  attr_reader :host, :cookies, :params, :session, :path

  def subdomain
    # @_subdomain ||= Subdomain.find_by_current_domain host
    @_subdomain ||= Subdomain.find_by_subdomain host.split('.').first
  end

  def session_variant
    return nil unless session[:variant_id].present?
    active_variants.find session[:variant_id]
  end

  def param_variant
    return nil unless params[:variant_id].present?
    active_variants.find params[:variant_id]
  end

  def calculate_variant
    # TODO алгоритм выборки версии
    active_variants.active.sample
  end

  def active_variants
    landing.variants.active
  end
end
