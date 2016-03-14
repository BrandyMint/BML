module YandexDirect
  class Sitelinks < BaseResource
    FIELD_NAMES = %w(Id Sitelinks).freeze

    def get(fieldNames: FIELD_NAMES, _selectionCriteria: {})
      make_response(
        method: :get,
        params: {
          FieldNames: fieldNames
        }
      )
    end
  end
end
