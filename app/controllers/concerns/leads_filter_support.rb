module LeadsFilterSupport
  ANY_MASK = '*'.freeze

  private

  def leads
    if current_account.features.leads_limit
      TariffLimitedLeadsQuery.new(filter: leads_filter).call
    else
      paginate LeadsQuery.new(filter: leads_filter).call
    end
  end

  def leads_filter
    @_leads_filter ||= LeadsFilter.new filter_params
  end

  def filter_params
    @_filter_params ||= build_filter_params
  end

  def build_filter_params
    {
      state: session_state,
      **params.slice(*LeadsFilter.attribute_set.map(&:name)).symbolize_keys,
      account: current_account,
      collection: current_collection,
      variant: current_variant
    }
      .compact
      .reject { |k, v| TrackingSupport::UTM_FIELDS.include?(k) && v == ANY_MASK }
  end
end
