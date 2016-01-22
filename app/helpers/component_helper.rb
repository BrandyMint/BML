module ComponentHelper
  def site_landing_component(landing_version)
    react_component 'LSite', present_landing_version(landing_version)
  rescue => err
    err.message
  end

  def editor_component(landing_version)
    react_component 'LPage', present_landing_version(landing_version)
  rescue => err
    err.message
  end

  private


  def present_landing_version(landing_version)
    data = {}
    blocks = []

    landing_version.sections.ordered.each do |s|
      data[s.uuid] = s.data
      blocks << { uuid: s.uuid, type: s.block_type, view: s.block_view }
    end

    { data: data, blocks: blocks, exitUrl: account_landing_analytics_path(landing_version.landing) }
  end
end
