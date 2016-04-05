require 'uuid'

module FunnelHelper
  def funnel(data)
    id = UUID.generate
    buffer = content_tag :canvas, 'loading funnel', id: id, width: 500, height: 350
    buffer << javascript_tag("FunnelChart(#{id.to_json}, #{data.to_json});")

    buffer
  end
end
