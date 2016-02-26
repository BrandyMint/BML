class LeadCreator
  include Virtus.model

  DATA_EXCEPTIONS = [:landing_version_uuid, :controller, :action, :utf8, :authenticity_token, :commit]

  attribute :params
  attribute :cookies

  def call
    collection.items.create! lead_attributes
  end

  private

  def lead_attributes
    utm.attributes.merge!(
      data: data,
      landing_version: landing_version
    )
  end

  def utm
    UtmEntity.new cookies.to_h
  end

  def collection
    find_collection || landing_version.landing.default_collection
  end

  def find_collection
    # TODO
  end

  def landing_version
    @_landing_version ||= LandingVersion.where(uuid: params[:landing_version_uuid]).first!
  end

  def data
    Hash[params.except(*DATA_EXCEPTIONS).map { |k, v| [k.downcase, v] }]
  end
end
