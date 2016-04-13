class Landing::LeadsController < Landing::BaseController
  include Landing::LeadsHelper
  include VariantInParameter

  layout 'leads'

  before_action :save_session_state

  def index
    leads_filter.popular_utm_options = popular_utm_options(current_landing.id)
    render locals: {
      collections:        current_landing.collections,
      current_collection: current_collection,
      columns:            columns,
      leads:              leads,
      filter:             leads_filter
    }
  end

  # TODO: move to collection/leads controller
  def edit
    lead = available_leads.find params[:id]
    render locals: { lead: lead, lead_data: lead.data, collection: lead.collection }, layout: 'lead_show'
  end

  def update
    lead = available_leads.find params[:id]
    lead.update! data: params[:lead_data]
    redirect_to landing_leads_path(current_landing, collection_id: lead.collection),
                flash: { success: I18n.t('flashes.lead.saved') }
  rescue ActiveRecord::RecordInvalid => err
    render 'edit', locals: { lead: err.record, lead_data: lead.data, collection: lead.collection }, flash: { error: err.message }, layout: 'lead_show'
  end

  # Предполагается что сюда будет параметром передаваться
  # формат для экспорта
  #
  def export
    content = LeadsSpreadsheet.new(current_collection, leads).to_csv
    filename = "#{current_collection}_#{I18n.l(Time.zone.now, format: :short)}"
    filename = filename.parameterize + '.csv'
    send_data(
      content,
      disposition: "attachment; filename=#{filename}",
      type: 'text/csv'
    )
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
      :sort_order, :sort_field, :limit, :state
    ).merge(
      account: current_account,
      collection: current_collection,
      variant: current_variant
    ).reverse_merge(
      state: session_state
    ).compact
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
    find_collection || current_landing.default_leads_collection
  end

  def available_leads
    Lead.where(collection_id: current_landing.collections)
  end

  def find_collection
    return nil unless params[:collection_id]
    current_landing.collections.find params[:collection_id]
  end
end
