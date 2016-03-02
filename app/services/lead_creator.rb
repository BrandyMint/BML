class LeadCreator
  include Virtus.model

  DATA_EXCEPTIONS = [:variant_uuid, :controller, :action, :utf8, :authenticity_token, :commit]

  attribute :params
  attribute :cookies

  def call
    lead = collection.leads.create! lead_attributes
    update_utm_values lead
  end

  private

  def lead_attributes
    utm.attributes.merge!(
      data: data,
      variant: variant
    )
  end

  def update_utm_values(lead)
    UtmValuesUpdate.new(lead: lead).call
  end

  def utm
    UtmEntity.new cookies.to_h
  end

  def collection
    find_collection || variant.landing.default_collection
  end

  def find_collection
    # TODO
  end

  def variant
    @_variant ||= Variant.where(uuid: params[:variant_uuid]).first!
  end

  def data
    Hash[params.except(*DATA_EXCEPTIONS).map { |k, v| [k.downcase, v] }]
  end
end
