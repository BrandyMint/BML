module CurrentLanding
  NoCurrentVariant = Class.new StandardError

  def current_variant
    if Thread.current[:variant].present?
      Thread.current[:variant]
    else
      fail NoCurrentVariant
    end
  end

  def set_current_variant(variant)
    Thread.current[:variant] = variant
  end

  def safe_current_variant
    current_variant
  rescue NoCurrentVariant
    nil
  end
end
