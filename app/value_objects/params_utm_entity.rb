class ParamsUtmEntity
  include Virtus.value_object

  values do
    attribute :utm_source, String
    attribute :utm_campaign, String
    attribute :utm_medium, String
    attribute :utm_term, String
    attribute :utm_content, String
  end
end
