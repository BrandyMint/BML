module ViewerLogger
  extend ActiveSupport::Concern

  included do
    before_action :log_request
  end

  private

  def utms
    ParamsUtmEntity.new(params)
                   .to_h
                   .merge(referer: request.referer)
  end

  def log_request
    LandingViewWorker.perform_async current_viewer_uid, utms, request.original_url, current_variant.id, request.user_agent, request.remote_ip
  end
end
