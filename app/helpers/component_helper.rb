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
    {
      application: {
        exitUrl:    account_landing_analytics_path(landing_version.landing),
        isEditMode: edit_mode
      },
      blocks: present_landing_blocks(landing_version)
    }
  end

  def present_landing_blocks(landing_version)
    landing_version.sections.ordered.map do |s|
      { uuid: s.uuid, type: s.block_type, view: s.block_view, data: s.data }
    end
  end
end
