module LandingsHelper
  def landing_leads_title(landing)
    count = landing.total_leads_count
    title = 'Заявки'
    return title if count == 0

    (title + "&nbsp;(#{count})").html_safe
  end
end
