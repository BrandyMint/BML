class UtmEntity
  include Virtus.value_object

  values do
    attribute :first_utm_source
    attribute :first_utm_campaign
    attribute :first_utm_medium
    attribute :first_utm_term
    attribute :first_utm_content
    attribute :first_referer
    attribute :last_utm_source
    attribute :last_utm_campaign
    attribute :last_utm_medium
    attribute :last_utm_term
    attribute :last_utm_content
    attribute :last_referer
  end
end
