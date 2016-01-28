module YandexDirect
  class BaseResource
    API_URL = 'https://api.direct.yandex.com/json/v5/'

    def initialize(token)
      @token = token
    end

    private

    attr_reader :token

    def make_response(body = {})
      request = Net::HTTP::Get.new uri, headers
      request.body = body.to_json
      log_request request
      parse_response http.request request
    end

    def parse_response(response)
      result = response.body.force_encoding 'UTF-8'

      log_result result

      MultiJson.load result
    end

    def uri
      URI.parse API_URL + path
    end

    def headers
      {
        'Accept-Language' => 'ru',
        'Authorization'   => "Bearer #{token}",
        'Content-Type'    => 'application/json; charset=utf-8'
      }
    end

    def http
      @_http ||= Net::HTTP.start uri.host, uri.port, use_ssl: true, verify_mode: OpenSSL::SSL::VERIFY_NONE # OpenSSL::SSL::VERIFY_PEER
    end

    def path
      self.class.name.split('::').last.parameterize
    end

    def log_request(request)
      log :request, request.body
    end

    def log_result(result)
      log :result, result
    end

    def log(prefix, data)
      filename = "./tmp/#{Time.now.to_i}-#{prefix}.json"
      IO.write filename, data
    end
  end
end

# Example Response headers
# > response.to_hash
# => {"server"=>["nginx"],
#  "date"=>["Thu, 28 Jan 2016 08:54:37 GMT"],
#  "content-type"=>["application/json; charset=utf-8"],
#  "transfer-encoding"=>["chunked"],
#  "connection"=>["close"],
#  "requestid"=>["3014956320487890461"],
#  "units"=>["138/330684/332000"],
#  "x-frame-options"=>["SAMEORIGIN"],
#  "x-xss-protection"=>["1; mode=block"],
#  "x-content-type-options"=>["nosniff"]}
