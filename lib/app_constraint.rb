require 'request_proxy'

class AppConstraint
  def self.matches?(request)
    # Если заходят по IP, до домена нет, значит это домашняя страница
    # return true if request.domain.blank?

    request = RequestProxy.new request

    request.app?
  end
end
