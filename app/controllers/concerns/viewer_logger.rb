module ViewerLogger
  extend ActiveSupport::Concern

  included do
    before_action :log_request
  end

  private

  def current_url
    request.original_url.split('?')[0]
  end

  def utms
    ParamsUtmEntity.new(params)
      .to_h
      .merge(referer: request.referer)
  end

  def log_request
    LandingViewWorker.perform_async current_viewer_uid, utms, current_url, current_variant.id
  end
end
