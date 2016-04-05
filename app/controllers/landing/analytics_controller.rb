class Landing::AnalyticsController < Landing::BaseController
  include CurrentVariant

  layout 'analytics'

  def index
    render locals: {
      insights: ExampleInsights.build,
      funnel_data: funnel_data
    }
  end

  def sources
    render locals: { sources_data: ExampleSourcesData.build }
  end

  def users
    render locals: { visits: ExampleVisits.build }
  end

  private

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
