module LandingsHelper
  def render_landing_variant(variant)
    props = landing_variant_store_state(variant)
    react_component 'Viewer', props, prerender: false
  end

  def landing_leads_title(landing)
    count = landing.total_leads_count
    title = 'Заявки'
    return title if count == 0

    (title + "&nbsp;(#{count})").html_safe
  end

  private

  def landing_variant_store_state(variant)
    data = Entities::LandingVersionEntity.represent(variant).as_json
    {
      application: {
        landingVersionUuid: variant.uuid
      },
      blocks: data[:sections]
    }
  end
end
