class Landing::AnalyticsController < Landing::BaseController
  include CurrentVariant

  layout 'analytics'

  def index
    render locals: {
      insights: ExampleInsights.build,
      funnel_data: funnel_data,
      total_funnel_conversion: total_funnel_conversion
    }
  end

  def sources
    render locals: { sources_data: ExampleSourcesData.build }
  end

  def users
    render locals: { visits: ExampleVisits.build }
  end

  private

  def total_funnel_conversion
    percent = current_landing.default_collection.leads_count.to_f / current_landing.viewers_count.to_f
    "#{(percent * 100).to_i}}%"
  rescue FloatDomainError
    '0%'
  end

  def funnel_data
    {
      values: [
        current_landing.viewers_count,
        current_landing.default_collection.leads_count
      ],
      labels: %w(
        Посетители
        Заявки)
    }
  end
end
