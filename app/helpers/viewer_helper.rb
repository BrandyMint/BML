module ViewerHelper
  def bugsnag_viewer_data
    bugsnag_user(current_viewer) +
      bugsnag_metadata(variant: current_variant.as_json(only: [:uuid, :landing_id, :updated_at]))
  end

  def views_link(viewer)
    count = viewer.views_count

    title = I18n.t :views_count, count: count

    if count > 0
      link_to title, account_landing_views_url(current_landing, viewer_uid: viewer.uid)
    else
      title
    end
  end
end
