class RequestForm < FormBase
  attribute :params
  validates :params, presence: true

  def save
    fail ActiveRecord::RecordInvalid.new(self) unless valid?

    landing_version.collection_items
      .create! data: data, collection: collection

  rescue ActiveRecord::RecordNotFound => err
    errors.add :base, err.message
    raise ActiveRecord::RecordInvalid.new(self)
  end

  private

  def collection
    landing_version.landing.collections.first!
  end

  def landing_version
    @_landing_version ||= LandingVersion.where(uuid: params[:landing_version_uuid]).first!
  end

  def data
    Hash[params.except(*data_exceptions).map { |k, v| [k.downcase, v] }]
  end

  def data_exceptions
    [:landing_version_uuid, :controller, :action, :utf8, :authenticity_token, :commit]
  end
end
