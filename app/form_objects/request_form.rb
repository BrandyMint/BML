class RequestForm < FormBase
  attribute :params
  validates :params, presence: true

  def save
    fail ActiveRecord::RecordInvalid.new(self) unless valid?

    variant
      .leads
      .create! data: data, collection: collection

  rescue ActiveRecord::RecordNotFound => err
    errors.add :base, err.message
    raise ActiveRecord::RecordInvalid.new(self)
  end

  private

  def collection
    variant.landing.collections.first!
  end

  def variant
    @_variant ||= Variant.where(uuid: params[:variant_uuid]).first!
  end

  def data
    Hash[params.except(*data_exceptions).map { |k, v| [k.downcase, v] }]
  end

  def data_exceptions
    [:variant_uuid, :controller, :action, :utf8, :authenticity_token, :commit]
  end
end
