module AccountLeadsHelper
  def filtered_variant(variant)
    return 'Все' unless variant.present?
    variant.to_s
  end
end
