# Фиксирует просмотр лендинга
class LandingViewWorker
  include Sidekiq::Worker

  def perform(uid, utms, url, variant_id, user_agent, remote_ip)
    CreateLandingView.new(
      viewer: find_viewer(uid),
      variant: find_variant(variant_id),
      user_agent: user_agent,
      remote_ip: remote_ip,
      url: url,
      utms: utms
    ).call
  rescue => err
    raise err unless Rails.env.production?
    Bugsnag.notify err, metaData: { uid: uid, utms: utms, url: url, variant_id: variant_id }
  end

  private

  def find_viewer(uid)
    Viewer.find_by_uid!(uid)
  end

  def find_variant(variant_id)
    Variant.find(variant_id)
  end
end
