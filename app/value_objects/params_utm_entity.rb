class ParamsUtmEntity
  include Virtus.value_object

  values do
    attribute :utm_source
    attribute :utm_campaign
    attribute :utm_medium
    attribute :utm_term
    attribute :utm_content
  end
end
