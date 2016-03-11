module LandingsHelper
  def landing_short_title(landing)
    truncate landing.title, length: 25
  end

  def setup_viewer_bml(variant: , viewer_uid: )
    config = {
      postLeadUrl: post_lead_url,
      # Не передаем, потом что лендинг могут сохранить и там окажется секретный api-ключ
      # apiUrl: api_v1_url,
      # apiKey: current_account.try(:api_key),
      variantUuid: variant.uuid,
      viewerUid: viewer_uid,
    }
    javascript_tag "window.bmlConfig = #{config.to_json}"
  end

  def landing_head_title(landing)
    landing.head_title.presence || landing.title
  end

  def render_variant(variant)
    props = variant_store_state(variant)
    react_component 'Viewer', props, prerender: false
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
        variantUuid: variant.uuid
      },
      blocks: data[:sections]
    }
  end
end
