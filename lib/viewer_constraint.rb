class ViewerConstraint
  extend CurrentLanding

  def self.matches?(request)
    variant = VariantSelector
      .new(
        host: request.host,
        path: request.path,
        session: request.session,
        params: request.params,
        cookies: request.cookies
        )
      .variant

    if variant.present?
      set_current_variant variant
      return true
    else
      set_current_variant nil
      return false
    end
  end
end
