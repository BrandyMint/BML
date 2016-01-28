class YandexClient
  API_URL = 'https://api.direct.yandex.com/json/v5/'

  CAMPAIGN_FIELD_NAMES = [
    'BlockedIps' , 'ExcludedSites' , 'Currency' , 'DailyBudget' , 'Notification' , 'EndDate' , 'Funds' , 'ClientInfo' , 'Id' , 'Name' , 'NegativeKeywords' , 'RepresentedBy' , 'StartDate' , 'Statistics' , 'State' , 'Status' , 'StatusPayment' , 'StatusClarification' , 'SourceId' , 'TimeTargeting' , 'TimeZone' , 'Type' ]

  def initialize(token)
    @token = token
  end

  def get_campaigns
    uri = URI.parse API_URL + 'campaigns'

    req = Net::HTTP::Get.new uri, headers

    req.body = {
      method: :get,
      params: {
        SelectionCriteria: {},
        FieldNames: CAMPAIGN_FIELD_NAMES
      }
    }.to_json

    http = build_http(uri)
    response = http.request req

    result = response.body.force_encoding 'UTF-8'

    log_result result

    MultiJson.load result
  end

  private

  attr_reader :token

  def headers
    {
      'Accept-Language' => 'ru',
      'Authorization'   => "Bearer #{token}",
      'Content-Type'    => 'application/json; charset=utf-8'
    }
  end

  def build_http(uri)
    Net::HTTP.start uri.host, uri.port, use_ssl: true, verify_mode: OpenSSL::SSL::VERIFY_NONE # OpenSSL::SSL::VERIFY_PEER
  end

  def log_result(result)
    filename = "./tmp/#{Time.now.to_i}.json"
    IO.write filename, result
    # File.open(filename, 'w') { |file| file.write result }
  end
end

# Response headers
# [11] pry(#<YandexClient>)> response.to_hash
# => {"server"=>["nginx"],
#  "date"=>["Thu, 28 Jan 2016 08:54:37 GMT"],
#   "content-type"=>["application/json; charset=utf-8"],
#    "transfer-encoding"=>["chunked"],
#     "connection"=>["close"],
#      "requestid"=>["3014956320487890461"],
#       "units"=>["138/330684/332000"],
#        "x-frame-options"=>["SAMEORIGIN"],
#         "x-xss-protection"=>["1; mode=block"],
#          "x-content-type-options"=>["nosniff"]}
#
