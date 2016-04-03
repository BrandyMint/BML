module VariantsHelper
  def variant_activation_button(variant)
    if variant.is_active
      hoverable_on_button(
        deactivate_landing_variant_path(current_landing, variant),
        title: 'Включен',
        hover_title: 'Отключить',
        disable_with: 'Отключаю'
      )
    else
      hoverable_off_button(
        activate_landing_variant_path(current_landing, variant),
        title: 'Отключен',
        hover_title: 'Включить',
        disable_with: 'Включаю'
      )
    end
  end
end
