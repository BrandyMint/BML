class CreateLead
  include Virtus.model(strict: true, nullify_blank: true)

  attribute :data,       Hash
  attribute :tracking,   String
  attribute :cookies,    Hash
  attribute :variant,    Variant
  attribute :viewer_uid, String

  def call
    ActiveRecord::Base.transaction do
      lead = collection.leads.create! lead_attributes
      update_utm_values lead

      attach_client lead
      lead
    end
  end

  private

  delegate :landing, to: :variant

  def attach_client(lead)
    AttachClient
      .new(lead: lead)
      .call
  rescue => e
    Bugsnag.notify e
  end

  def lead_attributes
    utm.attributes.merge!(
      data: data,
      variant: variant,
      viewer_uid: viewer_uid
    )
  end

  def update_utm_values(lead)
    UtmValuesUpdate.new(lead: lead).call
  end

  def utm
    @_utm ||= build_utm
  end

  def build_utm
    if tracking.present?
      build_utm_from_tracking tracking
    else
      CookiesUtmEntity.new cookies.to_h
    end
  end

  # {\"initial\":{\"params\":{},\"referrer\":\"http://3008.vkontraste.ru/account/landings/14/leads\"},\"current\":{\"params\":{\"utm_source\":\"123\"},\"referrer\":\"\"}}
  def build_utm_from_tracking(tracking)
    tracking = JSON.parse(tracking)
    first_params = OpenStruct.new(tracking['initial']['params'])
    first_referrer = tracking['initial']['referrer']

    last_params = OpenStruct.new(tracking['current']['params'])
    last_referrer = tracking['current']['referrer']

    CookiesUtmEntity.new(
      first_utm_source:   first_params.utm_source,
      first_utm_campaign: first_params.utm_campaign,
      first_utm_medium:   first_params.utm_medium,
      first_utm_term:     first_params.utm_term,
      first_utm_content:  first_params.utm_content,
      first_referer:      first_referrer,

      last_utm_source:    last_params.utm_source,
      last_utm_campaign:  last_params.utm_campaign,
      last_utm_medium:    last_params.utm_medium,
      last_utm_term:      last_params.utm_term,
      last_utm_content:   last_params.utm_content,
      last_referer:       last_referrer
    )
  rescue => err
    raise err unless Rails.env.production?
    Bugsnag.notify err, metaData: { tracking: tracking }
  end

  def collection
    find_collection || landing.default_collection
  end

  def find_collection
    # TODO: в будущем коллекция может указываться в параметрах
  end
end
