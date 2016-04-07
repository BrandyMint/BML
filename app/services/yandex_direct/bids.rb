module YandexDirect
  # Ресурс Bids
  class Bids < BaseResource
    FIELD_NAMES = %w(KeywordId AdGroupId CampaignId Bid ContextBid StrategyPriority
                     CompetitorsBids SearchPrices ContextCoverage MinSearchPrice CurrentSearchPrice AuctionBids).freeze

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
