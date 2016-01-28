module YandexDirect
  class AdGroups < BaseResource
    FIELD_NAMES = %w(Id CampaignId Status Name RegionIds NegativeKeywords TrackingParams Type)

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
