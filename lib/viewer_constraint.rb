class ViewerConstraint
  extend CurrentVariant
  extend CurrentViewer

  def self.matches?(request)
    variant =
      VariantSelector
      .new(
        host:    request.host,
        path:    request.path,
        session: request.session,
        params:  request.params,
        cookies: request.cookies
      )
      .variant

    if variant.present?
      self.current_variant = variant
      return true
    else
      self.current_variant = nil
      return false
    end
  end
end
