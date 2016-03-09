module AccountLeadsHelper
  def filtered_variant(variant)
    return 'Все' unless variant.present?
    variant.to_s
  end

  def popular_utm_options(landing_id = nil)
    options = {}
    Lead::UTM_FIELDS.each do |key|
      options.merge! key => UtmValuesQuery.new.popular_by_key(key, landing_id)
    end
    options
  end
end
