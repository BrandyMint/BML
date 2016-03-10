class LandingViewWorker
  include Sidekiq::Worker

  def perform(uid, utms, url, variant_id)
    ActiveRecord::Base.transaction do
      CreateLandingView.new(find_or_create_viewer(uid), utms, url, find_variant(variant_id)).call
    end
  rescue => err
    raise err unless Rails.env.production?
    Bugsnag.notify err, metaData: { uid: uid, utms: utms, url: url, variant_id: variant_id }
  end

  private

  def find_or_create_viewer(uid)
    FindOrCreateViewer.new(uid: uid).call
  end

  def find_variant(variant_id)
    Variant.includes(:account).find(variant_id)
  end
end
