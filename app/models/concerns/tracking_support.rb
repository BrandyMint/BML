module TrackingSupport
  extend ActiveSupport::Concern

  UTM_FIELDS = [
    :utm_source,
    :utm_campaign,
    :utm_medium,
    :utm_term,
    :utm_content,
    :referer
  ].freeze

  Lead::ATTRIBUTES = UTM_FIELDS + UTM_FIELDS.map { |a| "last_#{a}" } + UTM_FIELDS.map { |a| "first_#{a}" }

  included do
    before_create :fill_current_utms
  end

  UTM_FIELD_DEFINITIONS = UTM_FIELDS.map do |f|
    FieldDefinition.new(
      key: f,
      item_key: f,
      title: I18n.t("utm_fields.#{f}")
    )
  end

  private

  def fill_current_utms
    # TODO: думать какие устанвить first/last
    self.utm_source = last_utm_source
    self.utm_campaign = last_utm_campaign
    self.utm_medium = last_utm_medium
    self.utm_term = last_utm_term
    self.utm_content = last_utm_content

    self.referer = last_referer.presence || first_referer
  end
end
