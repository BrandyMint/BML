class ViewerConstraint
  include CurrentVariant

  def matches?(request)
    variant = select_variant request
    if variant.present?
      self.current_variant = variant
      return true
    else
      self.current_variant = nil
      return false
    end
  end

  private

  def select_variant(request)
    VariantSelector
      .new(
        host:    request.host,
        path:    request.path,
        session: request.session,
        params:  request.params,
        cookies: request.cookies
      )
      .variant
  end
end
