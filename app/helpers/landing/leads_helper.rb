module Landing::LeadsHelper
  def filtered_variant(variant)
    return 'Все' unless variant.present?
    variant.to_s
  end

  def popular_utm_options(landing_id = nil)
    options = {}
    TrackingSupport::UTM_FIELDS.each do |key|
      options.merge! key => UtmValuesQuery.new.popular_by_key(key, landing_id)
    end
    options
  end

  def leads_states_counts(collection)
    LeadsFilter::STATES_OPTIONS
      .reduce({}) do |acc, state|
      acc.merge! state => leads_state_count(collection, state)
    end
  end

  def leads_state_count(collection, state)
    if state == LeadsFilter::STATE_ANY
      collection.leads.count
    else
      collection.leads.with_state(*LeadsFilter.state_for_query(state)).count
    end
  end

  def state_tab_class(state, is_active)
    return 'bottom-default' unless is_active
    'bottom-' + state_color(state)
  end

  def lead_state(state)
    content_tag :span, state.text, class: 'label label-md label-' + state_color(state)
  end

  private

  def state_color(state)
    case state
    when LeadStates::STATE_ACCEPTED
      'success'
    when LeadStates::STATE_DECLINED
      'danger'
    when LeadStates::STATE_NEW
      'warning'
    else
      'primary'
    end
  end
end
