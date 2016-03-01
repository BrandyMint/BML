module LandingsHelper
  def render_variant(variant)
    props = variant_store_state(variant)
    react_component 'Viewer', props, prerender: true
  end

  def landing_leads_title(landing)
    count = landing.total_leads_count
    title = 'Заявки'
    return title if count == 0

    (title + "&nbsp;(#{count})").html_safe
  end

  private

  def variant_store_state(variant)
    data = Entities::VariantEntity.represent(variant).as_json
    {
      application: {
        landingVariantUuid: variant.uuid
      },
      blocks: data[:sections]
    }
  end
end
