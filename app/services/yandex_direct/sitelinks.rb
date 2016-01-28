module YandexDirect
  class Sitelinks < BaseResource
    FIELD_NAMES = %w(Id Sitelinks)

    def get(fieldNames: FIELD_NAMES, selectionCriteria: {})
      make_response(
        method: :get,
        params: {
          FieldNames: fieldNames
        }
      )
    end
  end
end
