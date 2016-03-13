module VariantInParameter
  def current_variant
    find_variant || current_landing.default_variant
  end

  def find_variant
    return nil unless params[:variant_id]

    current_landing.variants.find_by id: params[:variant_id]
  end
end
