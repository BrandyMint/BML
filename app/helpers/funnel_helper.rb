require 'uuid'

module FunnelHelper
  # https://github.com/promotably/funnel-chart
  #
  DEFUALT_OPTIONS = {
    maxFontSize: 18
  }

  def funnel(data)
    id = UUID.generate
    buffer = content_tag :canvas, 'loading funnel', id: id, width: 500, height: 350
    data = DEFUALT_OPTIONS.merge data
    buffer << javascript_tag("FunnelChart(#{id.to_json}, #{data.to_json});")

    buffer
  end
end
