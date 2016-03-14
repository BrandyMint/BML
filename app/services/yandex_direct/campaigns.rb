module YandexDirect
  # https://tech.yandex.ru/direct/doc/dg/concepts/about-docpage/
  #
  class Campaigns < BaseResource
    TYPES    = %w(TEXT_CAMPAIGN MOBILE_APP_CAMPAIGN DYNAMIC_TEXT_CAMPAIGN).freeze
    STATES   = %w(ARCHIVED CONVERTED ENDED OFF ON SUSPENDED).freeze
    STATUSES = %w(ACCEPTED DRAFT MODERATION REJECTED).freeze

    FIELD_NAMES = %w(BlockedIps ExcludedSites Currency DailyBudget Notification
                     EndDate Funds ClientInfo Id Name NegativeKeywords
                     RepresentedBy StartDate Statistics State Status
                     StatusPayment StatusClarification SourceId TimeTargeting TimeZone Type).freeze

    SHORT_FIELD_NAMES = %w(Type Funds Currency Id Name Statistics ClientInfo State Status).freeze

    def get(fieldNames: FIELD_NAMES)
      make_response(
        method: :get,
        params: {
          SelectionCriteria: {},
          FieldNames: fieldNames
        }
      )
    end
  end
end
