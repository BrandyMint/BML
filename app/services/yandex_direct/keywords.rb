module YandexDirect
  class Keywords < BaseResource
    FIELD_NAMES = %w(Id Keyword State Status AdGroupId CampaignId Bid ContextBid StrategyPriority UserParam1 UserParam2 Productivity StatisticsSearch StatisticsNetwork).freeze

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
