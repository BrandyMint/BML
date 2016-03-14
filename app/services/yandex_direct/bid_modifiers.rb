module YandexDirect
  class BidModifiers < BaseResource
    FIELD_NAMES = %w(Id CampaignId AdGroupId Level Type).freeze
    LEVELS = %w(CAMPAIGN AD_GROUP).freeze

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
