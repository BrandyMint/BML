module YandexDirect
  class Ads < BaseResource
    STATES = %w(OFF ON SUSPENDED OFF_BY_MONITORING ARCHIVED).freeze
    FIELD_NAMES = %w(AdCategories AgeLabel AdGroupId CampaignId Id State Status StatusClarification Type).freeze

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
