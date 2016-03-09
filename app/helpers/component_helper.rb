module ComponentHelper
  def init_view(variant)
    data = initial_state(variant, false)

    javascript_tag "window.initApp(#{data.to_json})"
  end

  def init_editor(variant)
    data = initial_state(variant, true)

    javascript_tag "window.initApp(#{data.to_json})"
  end

  private

  def initial_state(variant, edit_mode)
    json = Entities::VariantEntity.represent(variant).as_json[:sections]
    {
      application: {
        exitUrl:              account_landing_analytics_path(variant.landing),
        isEditMode:           edit_mode,
        isSaving:             false,
        variant_uuid: variant.uuid,
        api_key:              current_account.api_key,
        hasUnsavedChanges:    false
      },
      blocks: Entities::VariantEntity.represent(variant).as_json[:sections]
    }
  end
end
