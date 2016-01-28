module YandexDirect
  class Ads < BaseResource
    STATES = %w(OFF ON SUSPENDED OFF_BY_MONITORING ARCHIVED)
    FIELD_NAMES = %w(AdCategories AgeLabel AdGroupId CampaignId Id State Status StatusClarification Type)

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
