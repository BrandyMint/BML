module YandexDirect
  class BidModifiers < BaseResource
    FIELD_NAMES = %w(Id CampaignId AdGroupId Level Type)
    LEVELS = %w(CAMPAIGN AD_GROUP)

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
