module AccountLeadsHelper
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

  def filtered_state(state)
    case state
    when LeadsFilter::STATE_NOT_DECLINED,
         LeadStates::STATE_NEW,
         LeadStates::STATE_ACCEPTED,
         LeadStates::STATE_DECLINED
      t("leads_filter.state.#{state}")
    else
      t('leads_filter.state.any')
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
