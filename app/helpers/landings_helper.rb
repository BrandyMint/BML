module LandingsHelper
  def landing_short_title(landing)
    truncate_middle landing.title, length: 25
  end

  def setup_viewer_bml(variant:, viewer_uid:)
    config = {
      postLeadUrl: post_lead_url,
      # Не передаем, потом что сайт могут сохранить и там окажется секретный api-ключ
      # apiUrl: api_v1_url,
      # apiKey: current_account.try(:api_key),
      variantUuid: variant.uuid,
      viewerUid: viewer_uid
    }
    javascript_tag "window.bmlConfig = #{config.to_json}"
  end

  def landing_head_title(landing)
    landing.head_title.presence || landing.title
  end

  def render_variant(variant)
    props = variant_store_state(variant)
    react_component 'Viewer', props, prerender: true
  rescue ExecJS::ProgramError => err
    raise err unless Rails.env.production?
    Bugsnag.notify err, metaData: { variant: variant.uuid }

    react_component 'Viewer', props, prerender: false
  end

  def landing_leads_details(landing)
    I18n.t :leads_count, count: landing.total_leads_count
  end

  def landing_leads_title(landing, current_collection = nil)
    collection = current_collection || landing.default_collection
    title = collection.to_s
    count = collection.leads.count

    return title if count == 0

    (title + "&nbsp;<span class=\"text-muted\">(#{count})</span>").html_safe
  end

  private

  def variant_store_state(variant)
    Entities::VariantEntity.represent(variant).as_json
  end
end
