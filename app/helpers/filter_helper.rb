module FilterHelper
  def filter_variant(filter)
    render 'filter_dropdown',
           field_name: :variant_id,
           current_value: filter.variant_id,
           title: "Вариант: #{filtered_variant(filter.variant)}",
           collection: current_landing.variants.ordered
  end

  private

  def filtered_variant(variant)
    return 'Все' unless variant.present?
    variant.to_s
  end
end
