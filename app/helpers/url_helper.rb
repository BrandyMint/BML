module UrlHelper
  def url_without_protocol(url)
    return '' unless url.present?
    a = Addressable::URI.parse url
    a.host + a.path
  end
end
