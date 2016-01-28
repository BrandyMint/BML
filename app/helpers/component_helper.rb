module ComponentHelper
  def init_view(landing_version)
    data = initial_state(landing_version, false)

    javascript_tag "window.initApp(#{data.to_json})"
  end

  def init_editor(landing_version)
    data = initial_state(landing_version, true)

    javascript_tag "window.initApp(#{data.to_json})"
  end

  private

  def initial_state(landing_version, edit_mode)
    Entities::LandingVersionEntity.represent(landing_version)
    {
      application: {
        exitUrl:              account_landing_analytics_path(landing_version.landing),
        isEditMode:           edit_mode,
        landing_version_uuid: landing_version.uuid,
        api_key:              current_account.api_key,
        hasUnsavedChanges:    false
      },
      blocks:               Entities::LandingVersionEntity.represent(landing_version).as_json[:sections]
    }
  end
end
