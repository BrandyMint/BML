class Account::LeadsController < Landing::BaseController
  include AccountLeadsHelper
  include VariantInParameter

  layout 'leads'

  before_action :save_session_state

  def index
    leads_filter.popular_utm_options = popular_utm_options(current_landing.id)
    render locals: {
      collections:        current_landing.collections,
      current_collection: current_collection,
      columns:             columns,
      leads:              leads,
      filter:             leads_filter
    }
  end

  def show
    render locals: { lead: lead }, layout: 'lead_show'
  end

  def accept
    lead.accept
    redirect_to :back
  end

  def decline
    lead.decline
    redirect_to :back
  end

  private

  def columns
    current_collection.columns.ordered.to_a + usable_tracking_columns
  end

  def usable_tracking_columns
    TrackingSupport::UTM_FIELD_DEFINITIONS.select do |fd|
      current_collection.leads.where.not(fd.key => nil).any?
    end
  end

  def lead
    current_landing.leads.find params[:id]
  end

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
    params.slice(
      :sort_order,
      :sort_field,
      :limit,
      :state
    ).merge(
      account: current_account,
      collection: current_collection,
      variant: current_variant
    ).reverse_merge(
      state: session_state
    )
  end

  def session_state
    session[session_state_key]
  end

  def session_state_key
    "#{current_landing.id}:lead_state"
  end

  def save_session_state
    session[session_state_key] = params[:state] if LeadsFilter::STATES_OPTIONS.include? params[:state]
  end

  def current_collection
    find_collection || current_landing.default_collection
  end

  def find_collection
    return nil unless params[:collection_id]

    current_landing.collections.find params[:collection_id]
  end
end
