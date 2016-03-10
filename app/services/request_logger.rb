class RequestLogger
  include Virtus.model

  attribute :worker
  attribute :request
  attribute :variant, Variant

  def call
    worker.perform_async uid, utms, url, variant.id
  end

  private

  def utms
    ParamsUtmEntity.new(request.params)
      .to_h.merge(referer: request.referer)
  end

  def uid
    request.session.id
  end

  def url
    request.original_url
  end
end
