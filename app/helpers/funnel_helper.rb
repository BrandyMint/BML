require 'uuid'

module FunnelHelper
  # https://github.com/promotably/funnel-chart
  #
  DEFUALT_OPTIONS = {
    maxFontSize: 18
  }.freeze

  def funnel(data)
    id = UUID.generate
    buffer = content_tag :canvas, 'loading funnel', id: id, width: 500, height: 350
    data = DEFUALT_OPTIONS.merge data
    buffer << javascript_tag("FunnelChart(#{id.to_json}, #{data.to_json});")

    buffer
  end

  def total_funnel_conversion
    find_funnel_conversion
  end

  private

  def find_funnel_conversion
    percent = current_landing.default_leads_collection.leads_count.to_f / current_landing.viewers_count.to_f
    "#{(percent * 100).to_i}%"
  rescue FloatDomainError
    '0%'
  end
end
