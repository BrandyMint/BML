class RequestLogger
  include Virtus.model

  attribute :worker
  attribute :request
  attribute :viewer, Viewer
  attribute :variant, Variant

  def call
    worker.perform_async viewer.uid, utms, url, variant.id
  end

  private

  def utms
    ParamsUtmEntity.new(request.params)
      .to_h.merge(referer: request.referer)
  end

  def url
    request.original_url.split('?')[0]
  end
end
