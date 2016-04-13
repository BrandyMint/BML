module Payments
  class Secure3dRedirect < StandardError
    attr_reader :resp

    def initialize(resp)
      @resp = resp
    end
  end
end
