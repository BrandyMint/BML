module Landing::LeadsHelper
  def popular_utm_options(key)
    UtmValuesQuery.new.popular_by_key(key, current_landing.id)
  end

  def leads_state_count(collection, state)
    if state == LeadsFilter::STATE_ANY
      collection.leads.count
    else
      collection.leads.with_state(*LeadsFilter.state_for_query(state)).count
    end
  end

  def state_tab_class(state, is_active)
    return unless is_active
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
