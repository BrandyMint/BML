module YandexDirect
  class AdGroups < BaseResource
    FIELD_NAMES       = %w(Id CampaignId Status Name RegionIds NegativeKeywords TrackingParams Type)
    TYPES             = %w(TEXT_AD_GROUP MOBILE_APP_AD_GROUP DYNAMIC_TEXT_AD_GROUP)
    STATUSES          = %w(ACCEPTED DRAFT MODERATION PREACCEPTED REJECTED)
    APP_ICON_STATUSES = %w(ACCEPTED MODERATION REJECTED)

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
