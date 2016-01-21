class SiteConstraint
  extend CurrentAccount
  extend CurrentLanding

  def self.matches?(request)
    landing_version = LandingVersionSelector
      .new(host: request.host, session: request.session, params: request.params, cookies: request.cookies)
      .landing_version

    if landing_version.present?
      set_current_landing_version landing_version
      return true
    else
      set_current_landing_version nil
      return false
    end
  end
end
