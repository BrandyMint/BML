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

  def lead_state(state)
    css = case state
          when LeadStates::STATE_ACCEPTED
            'label-success'
          when LeadStates::STATE_DECLINED
            'label-default'
          else
            'label-warning'
          end

    content_tag :span, state.text, class: 'label label-md ' + css
  end
end
