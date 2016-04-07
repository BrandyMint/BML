module YandexDirect
  # Ресурс Ad_groups
  class AdGroups < BaseResource
    FIELD_NAMES       = %w(Id CampaignId Status Name RegionIds NegativeKeywords TrackingParams Type).freeze
    TYPES             = %w(TEXT_AD_GROUP MOBILE_APP_AD_GROUP DYNAMIC_TEXT_AD_GROUP).freeze
    STATUSES          = %w(ACCEPTED DRAFT MODERATION PREACCEPTED REJECTED).freeze
    APP_ICON_STATUSES = %w(ACCEPTED MODERATION REJECTED).freeze

    def get(fieldNames: FIELD_NAMES, selectionCriteria: {})
      make_response(
        method: :get,
        params: {
          SelectionCriteria: selectionCriteria,
          FieldNames: fieldNames
        }
      )
    end
  end
end
